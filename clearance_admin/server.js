const xlsx = require("xlsx");
const fileUpload = require("express-fileupload");
const express = require("express");
const morgan = require("morgan");
const dotenv = require("dotenv");
const flash = require('express-flash');
const session = require("express-session");
const mysql = require("mysql");
const passport = require("passport");
const LocalStrategy = require("passport-local").Strategy;
dotenv.config({ path: "config.env" });
const path = require("path");
const app = express();
const port = 8088;

let mysqlx = mysql.createConnection({
  host: "127.0.0.1",
  user: "root",
  port: 3306,
  password: "my-secret-password",
  database: "clrs",
});

mysqlx.connect((err) => {
  if (!err) {
    console.log("db connection successful");
  } else {
    console.log("db connection failed" + JSON.stringify(err, undefined, 2));
  }
});

app.use(morgan("tiny"));
app.use(express.urlencoded({ extended: false }));
app.use(express.json());
app.set("view engine", "ejs");
app.use(
  session({
    cookie: { maxAge: 86400000  },
    secret: "woot",
    resave: false,
    saveUninitialized: false,
  })
);
app.use(flash());
app.use(express.static('public'));
app.use((req, res, next) => {
  res.header("Cache-Control", "private, no-cache, no-store, must-revalidate");
  res.header("Expires", "-1");
  res.header("Pragma", "no-cache");
  next();
});

const passportFirst = require("passport");
app.use("/adminlogin", passportFirst.initialize());
app.use("/adminlogin", passportFirst.session());
app.use(flash());

passportFirst.use(
  "local-first",
  new LocalStrategy((username, password, done) => {
    mysqlx.query(
      "SELECT * FROM adminusers WHERE username = ? AND password = ?",
      [username, password],
      (err, results) => {
        if (err) return done(err);
        if (results.length === 0) {
          return done(null, false, {
            message: "Incorrect username or password",
          });
        }
        const user = results[0];
        return done(null, user);
      }
    );
  })
);

passportFirst.serializeUser((user, done) => {
  done(null, user.username);
});

passportFirst.deserializeUser((username, done) => {
  mysqlx.query(
    "SELECT * FROM adminusers WHERE username = ?",
    [username],
    (err, results) => {
      if (err) return done(err);
      const user = results[0];

      return done(null, user);
    }
  );
});


app.post("/adminlogin", function (req, res, next) {
  passport.authenticate("local-first", function (err, user, info) {
    if (err) {
      return next(err);
    }
    if (!user) {
      req.flash("error", info.message);
      return res.redirect("/adminlogin");
    }
    req.logIn(user, function (err) {
      if (err) {
        return next(err);
      }

      req.session.username = req.user.username;
      res.redirect("/excelupload");
    });
  })(req, res, next);
});

app.get("/", function (req, res) {
  res.redirect("/adminlogin");
});


app.get("/adminlogin", function (req, res) {
  if (req.session.username) {
  } else {
    res.render("adminlogin", { message: req.flash("error") });
  }
});
app.get("/excelupload", ensureAuthenticated, (req, res) => {
  const errorFlashMessage = req.flash("error");
  console.log("lnmf");
  console.log(errorFlashMessage);
  const successFlashMessage = req.flash("success");
  res.render("excelupload", {
    errorFlashMessage: errorFlashMessage,
    successFlashMessage: successFlashMessage,
  });
});

app.use(fileUpload({
  limits: { fileSize: 50 * 1024 * 1024 }, // Maximum file size (50MB)
  useTempFiles: true,
  tempFileDir: path.join(__dirname, "temp"),
  safeFileNames: true,
  preserveExtension: true,
  createParentPath: true,
  abortOnLimit: true,
  responseOnLimit: "File size limit has been reached.",
  fileFilter: (req, file, callback) => {
    const filetypes = [
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
    ];
    if (filetypes.includes(file.mimetype)) {
      callback(null, true);
    } else {
      callback(new Error("Only XLSX files are allowed."));
    }
  },
}));



app.post("/upload", (req, res) => {
  if (!req.files || Object.keys(req.files).length === 0) {
    return res.status(400).send("No files were uploaded.");


  }

  if (!req.files || Object.keys(req.files).length === 0) {
    return res.status(400).send("No files were uploaded.");
  }

  let uploadedFile = req.files.myfile;


  // Check file type
  if (uploadedFile.mimetype !== "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet") {
    req.flash("error", "Only XLSX files are allowed.");
    return res.redirect("/excelupload");
  }


  let uploadPath = path.join(__dirname, "uploads", "testexcel.xlsx");

  uploadedFile.mv(uploadPath, (err) => {
    if (err) {
      // Error occurred while saving the file
      console.error(err);
      req.flash("error", "Error occurred while uploading the file.");
    return res.redirect("/excelupload");
    }

    let workbook = xlsx.readFile(uploadPath);
    let worksheet = workbook.Sheets[workbook.SheetNames[0]];
    let data = xlsx.utils.sheet_to_json(worksheet, { header: 1 });

    let values = [];
    for (let i = 1; i < data.length; i++) {
      let row = data[i];
      values.push([
        row[0],
        row[1],
        row[2],
        row[3],
        row[4],
        row[5],
        row[6],
        row[7],
        row[8],
        row[9],
        row[10],
      ]);
    }

    console.log(values);

    let sql =
      "INSERT INTO upload (Registration_Number, Name, Roll_Number, Branch, Course, Semester, Section, Session, Year, Mobile_Number, Email) VALUES ?";
    mysqlx.query(sql, [values], (err, result) => {
      if (err) {
        // Error occurred while inserting data
        
    //     const errorMessage = err.sqlMessage;
    //     const errorHTML = `<div class="error-message">
    //     <span class="error-icon">&#9888;</span>
    //     <span class="error-text">${errorMessage}</span>
    // </div>`;
    console.error(err);
    const errorMessage = err.sqlMessage;
    req.flash(
      "error",
      `Error occurred while inserting data to the database: ${errorMessage}`
    );
    return res.redirect("/excelupload");
  
      }

      req.flash("success", "File uploaded and data inserted to the database.");
  return res.redirect("/excelupload");
    });
  });
});


function ensureAuthenticated(req, res, next) {
  if (req.session.username) {
    console.log(req.session.username);
    return next();
  } else {
    res.redirect("/adminlogin");
  }
}


app.get("/logout", function (req, res) {
  req.session.destroy(function (err) {
    // Destroy the session
    if (err) {
      console.log(err);
    }
    res.redirect("/adminlogin"); // Redirect to the login page
  });
});



app.listen(port, () => {
  console.log(`server is running`);
});
