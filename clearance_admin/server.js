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
const port = 8081;

let mysqlx = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "clearance",
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
    cookie: { maxAge: 60000 },
    secret: "woot",
    resave: false,
    saveUninitialized: false,
  })
);
app.use(flash());
app.use(express.static('public'));


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
  res.render("index", { user: req.user });
});


app.get("/adminlogin", function (req, res) {
  res.render("adminlogin", { message: req.flash("error") });
});

app.get("/excelupload", ensureAuthenticated, (req, res) => {
  res.render("excelupload");
});

app.use(fileUpload());



app.post("/upload", (req, res) => {
  if (!req.files || Object.keys(req.files).length === 0) {
    return res.status(400).send("No files were uploaded.");
  }

  let uploadedFile = req.files.myfile;
  let uploadPath = path.join(__dirname, "uploads", "testexcel.xlsx");

  uploadedFile.mv(uploadPath, (err) => {
    if (err) {
      // Error occurred while saving the file
      console.error(err);
      return res.status(500).send("Error occurred while uploading the file.");
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
        
        const errorMessage = err.sqlMessage;
        const errorHTML = `<div class="error-message">
        <span class="error-icon">&#9888;</span>
        <span class="error-text">${errorMessage}</span>
    </div>`;
return res.status(500).send(`Error occurred while inserting data to the database: ${errorHTML}`);
  
      }

      res.send("File uploaded and data inserted to the database.");
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

app.listen(port, () => {
  console.log(`server is running`);
});
