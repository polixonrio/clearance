//Anshuman
const xlsx = require("xlsx");
const fileUpload = require("express-fileupload");
//Anshuman

const express = require("express");
const morgan = require("morgan");
const dotenv = require("dotenv");
const flash = require("express-flash");
const session = require("express-session");

const mysql = require("mysql");
const passport = require("passport");
const LocalStrategy = require("passport-local").Strategy;
dotenv.config({ path: "config.env" });
const path = require("path");
const app = express();
const port = 8089;

const adminlogin = require("./routes/adminlogin");
// const filter = require("./routes/filter");
// const login = require("./routes/login");

app.use("/adminlogin", adminlogin);
// app.use('/filter', filter);
// app.use('/login', login);

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
//Anshuman

//Anshuman
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

const passportFirst = require("passport");
app.use("/studentlogin", passportFirst.initialize());
app.use("/studentlogin", passportFirst.session());
app.use(flash());

passportFirst.use(
  "local-first",
  new LocalStrategy((username, password, done) => {
    mysqlx.query(
      "SELECT * FROM studentusers WHERE username = ? AND password = ?",
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

// Configure Passport serializer/deserializer functions for second view
passportFirst.serializeUser((user, done) => {
  done(null, user.id);
});

passportFirst.deserializeUser((id, done) => {
  mysqlx.query(
    "SELECT * FROM studentusers WHERE id = ?",
    [id],
    (err, results) => {
      if (err) return done(err);
      const user = results[0];
      return done(null, user);
    }
  );
});

app.post("/studentlogin", function (req, res, next) {
  passport.authenticate("local-first", function (err, user, info) {
    if (err) {
      return next(err);
    }
    if (!user) {
      req.flash("error", info.message);
      return res.redirect("/studentlogin");
    }
    req.logIn(user, function (err) {
      if (err) {
        return next(err);
      }

      req.session.username = req.user.username;

      res.redirect("/studentupdate");
    });
  })(req, res, next);
});

app.post("/studentupdate", function (req, res) {
  res.render("studentupdate", { message: req.flash("error") });
});

app.get("/studentlogin", function (req, res) {
  res.render("studentlogin", { message: req.flash("error") });
});

// Passport configuration
app.use(passport.initialize());
app.use(passport.session());
app.use(flash());

passport.use(
  "login",
  new LocalStrategy(function (username, password, done) {
    mysqlx.query(
      "SELECT * FROM users WHERE username = ?",
      [username],
      function (err, rows, fields) {
        if (err) {
          return done(err);
        }
        if (!rows.length) {
          return done(null, false, { message: "Incorrect username." });
        }
        if (rows[0].password != password) {
          return done(null, false, { message: "Incorrect password." });
        }
        return done(null, rows[0]);
      }
    );
  })
);

passport.serializeUser(function (user, done) {
  done(null, user.ID);
});

passport.deserializeUser(function (id, done) {
  mysqlx.query(
    "SELECT * FROM users WHERE id = ?",
    [id],
    function (err, rows, fields) {
      done(err, rows[0]);
    }
  );
});

// Middleware to make the current user available in templates
app.use(function (req, res, next) {
  res.locals.currentUser = req.user;
  next();
});

// Routes
app.get("/", function (req, res) {
  res.render("index", { user: req.user });
});

app.get("/login", function (req, res) {
  res.render("login", { message: req.flash("error") });
});

app.post("/login", function (req, res, next) {
  passport.authenticate("login", function (err, user, info) {
    if (err) {
      return next(err);
    }
    if (!user) {
      req.flash("error", info.message);
      return res.redirect("/login");
    }
    req.logIn(user, function (err) {
      if (err) {
        return next(err);
      }

      req.session.username = req.user.username;

      res.redirect("/filter");
    });
  })(req, res, next);
});

app.get("/filter", function (req, res) {
  const userId = req.user;
  // console.log(userId);
  // Retrieve batches from the batches table
  mysqlx.query(
    "SELECT DISTINCT Branch FROM students",
    function (err, branchRows, fields) {
      if (err) {
        console.log(err);
        res.status(500).send("Internal Server Error");
        return;
      }

      const Branches = branchRows.map((row) => row.Branch);

      // Retrieve courses from the students table
      mysqlx.query(
        "SELECT DISTINCT Course FROM students",
        function (err, courseRows, fields) {
          if (err) {
            console.log(err);
            res.status(500).send("Internal Server Error");
            return;
          }

          const Courses = courseRows.map((row) => row.Course);

          // Retrieve semesters from the students table
          mysqlx.query(
            "SELECT DISTINCT Semester FROM students",
            function (err, semRows, fields) {
              if (err) {
                console.log(err);
                res.status(500).send("Internal Server Error");
                return;
              }

              const Semesters = semRows.map((row) => row.Semester);

              // Retrieve sessions from the students table
              mysqlx.query(
                "SELECT DISTINCT Session FROM students",
                function (err, sesRows, fields) {
                  if (err) {
                    console.log(err);
                    res.status(500).send("Internal Server Error");
                    return;
                  }

                  const Sessions = sesRows.map((row) => row.Session);

                  // Retrieve sections from the students table
                  mysqlx.query(
                    "SELECT DISTINCT Section FROM students",
                    function (err, secRows, fields) {
                      if (err) {
                        console.log(err);
                        res.status(500).send("Internal Server Error");
                        return;
                      }

                      const Sections = secRows.map((row) => row.Section);
                      console.log(Semesters);
                      res.render("filter", {
                        Branches: Branches,
                        Semesters: Semesters,
                        Sessions: Sessions,
                        Sections: Sections,
                        Courses: Courses,
                        user: userId,
                      });
                    }
                  );
                }
              );
            }
          );
        }
      );
    }
  );
});

app.get("/logout", function (req, res) {
  req.session.destroy(function (err) {
    if (err) {
      console.error("Error destroying session: ", err);
    }
    res.clearCookie("connect.sid");
    res.redirect("/");
  });
});

app.post("/filter", function (req, res) {
  const userId = req.session.username;

  // const users = req.body.username;
  const Registration_Number = req.body.Registration_Number;
  const Name = req.body.Name;
  const Roll_Number = req.body.Roll_Number;
  const Course = req.body.Course;
  const Branch = req.body.Branch;
  const Semester = req.body.Semester;
  const Section = req.body.Section;

  const Session = req.body.Session;
  const Year = req.body.Year;
  const Mobile_Number = req.body.Mobile_Number;

  req.session.Registration_Number = req.body.Registration_Number;
  req.session.Name = req.body.Name;
  req.session.Roll_Number = req.body.Roll_Number;
  req.session.Course = req.body.Course;
  req.session.Branch = req.body.Branch;
  req.session.Section = req.body.Section;
  req.session.Semester = req.body.Semester;
  req.session.Session = req.body.Session;
  req.session.Year = req.body.Year;
  req.session.Mobile_Number = req.body.Mobile_Number;

  // console.log(userId);
  // Construct SQL query to retrieve appropriate rows

  // Retrieve access rights for current user from user_student_access table
  mysqlx.query(
    "SELECT access_rights FROM users WHERE username = ?",
    [userId],
    function (err, rows, fields) {
      if (err) {
        console.log(err);
        res.status(500).send("Internal Server Error 1");
        return;
      }

      if (rows.length === 0) {
        // User does not have any access rights
        res.status(401).send("Unauthorized");
        return;
      }

      const accessRights = rows[0].access_rights.split(",");

      // Construct SELECT query with specified access rights
      const selectCols = accessRights.join(",");
      console.log(selectCols);
      // const queryx = `SELECT ${selectCols} FROM students`;
      let query = `SELECT ${selectCols} FROM students WHERE `;
      if (Registration_Number)
        query += " Registration_Number = " + mysql.escape(batch);
      // if (Name) query += " AND semester = " + mysql.escape(Name);
      if (Roll_Number)
        query += " AND Roll_Number = " + mysql.escape(Roll_Number);
      if (Course) query += " Course = " + mysql.escape(Course);
      if (Branch) query += " AND Branch = " + mysql.escape(Branch);
      if (Semester) query += " AND Semester = " + mysql.escape(Semester);
      if (Session) query += " AND Session = " + mysql.escape(Session);
      if (Year) query += " AND Year = " + mysql.escape(Year);
      if (Section) query += " AND Section = " + mysql.escape(Section);

      // Execute SELECT query
      mysqlx.query(query, function (err, rows, fields) {
        if (err) {
          console.log(err);
          res.status(500).send("Internal Server Error");
          return;
        }

        const students1 = rows.map((row) => {
          return Object.assign({}, row);
        });

        console.log(students1);
        res.render("students", {
          students: students1,
          user: userId,
        });
      });
    }
  );
});

// app.get("/students", function (req, res) {
//   // req.session.batch = req.body.batch ;
//   // req.session.semester = req.body.semester ;
//   // req.session.department = req.body.department ;
//   // req.session.section = req.body.section ;

//   const batch = req.session.batch;
//   const semester = req.session.semester;
//   const department = req.session.department;
//   const section = req.session.section;

//   const userId = req.session.username;
//   mysqlx.query(
//     "SELECT access_rights FROM users WHERE username = ?",
//     [userId],
//     function (err, rows, fields) {
//       if (err) {
//         console.log(err);
//         res.status(500).send("Internal Server Error");
//         return;
//       }

//       if (rows.length === 0) {
//         // User does not have any access rights
//         res.status(401).send("Unauthorized");
//         return;
//       }

//       const accessRights = rows[0].access_rights.split(",");

//       // Construct SELECT query with specified access rights
//       const selectCols = accessRights.join(",");
//       // const queryx = `SELECT  FROM students`;

//       let query = `SELECT ${selectCols} FROM students WHERE `;
//       if (batch) query += " batch = " + mysql.escape(batch);
//       if (semester) query += " AND semester = " + mysql.escape(semester);
//       if (department) query += " AND department = " + mysql.escape(department);
//       if (section) query += " AND section = " + mysql.escape(section);

//       // Execute SELECT query
//       mysqlx.query(query, function (err, srows, fields) {
//         if (err) {
//           console.log(err);
//           res.status(500).send("Internal Server Error");
//           return;
//         }
//         res.render("students", { students: srows });
//       });
//     }
//   );
// });

app.post("/students/:Registration_Number/verify", function (req, res) {
  // console.log(req.params);
  // console.log(req.session.username);
  const usertable = req.session.username;
  const studentId = req.params.Registration_Number;
  const query = `UPDATE ${usertable} SET verification = "TRUE" WHERE Registration_Number = ?`;
  mysqlx.query(query, [studentId], function (err, result) {
    if (err) {
      console.log(err);
      res.status(500).send("Internal Server Error");
      return;
    }
    res.redirect("/students");
  });
});

app.post("/students/:Registration_Number/unverify", function (req, res) {
  // console.log(req.params);
  console.log(req.session.username);
  const usertable = req.session.username;
  const studentId = req.params.Registration_Number;
  const query = `UPDATE ${usertable} SET verification = "FALSE" WHERE Registration_Number =  ?`;
  console.log(query);
  mysqlx.query(query, [studentId], function (err, result) {
    if (err) {
      console.log(err);
      res.status(500).send("Internal Server Error");
      return;
    }
    res.redirect("/students");
  });
});

//Anshuman Codes start

// making route to page to generate and download pdf
app.get("/formgenerate", function (req, res) {
  res.render("formgenerate");
});

app.get("/excelupload", (req, res) => {
  res.render("excelupload");
});

app.use(fileUpload());

app.post("/upload", (req, res) => {
  // check if file was uploaded
  if (!req.files || Object.keys(req.files).length === 0) {
    return res.status(400).send("No files were uploaded.");
  }

  // get uploaded file
  let uploadedFile = req.files.myfile;

  // set upload path and file name
  let uploadPath = path.join(__dirname, "uploads", "testexcel.xlsx");

  // save uploaded file
  uploadedFile.mv(uploadPath, (err) => {
    if (err) {
      return res.status(500).send(err);
    }

    // read uploaded file and parse data using xlsx module
    let workbook = xlsx.readFile(uploadPath);
    let worksheet = workbook.Sheets[workbook.SheetNames[0]];
    let data = xlsx.utils.sheet_to_json(worksheet, { header: 1 });

    // extract data into arrays for MySQL insertion
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

    // insert data from uploaded file to MySQL database
    let sql =
      "INSERT INTO upload (Registration_Number, Name, Roll_Number, Branch, Course, Semester, Section, Session, Year, Mobile_Number, Email) VALUES ?";
    mysqlx.query(sql, [values], (err, result) => {
      if (err) {
        return res.status(500).send(err);
      }

      res.send("File uploaded and data inserted to database.");
    });
  });
});

app.post("/adminexcelredirect", function (req, res, next) {
  // Need to make authentication currently redirecting after adminlogin to excelupload
  const username = req.body.username;
  const password = req.body.password;
  if (username === "admin" && password === "admin") {
    res.redirect("/excelupload");
  } else {
    res.redirect("/adminlogin");
  }
});
//Anshuman Codes end

app.listen(port, () => {
  console.log(`server is running`);
});
