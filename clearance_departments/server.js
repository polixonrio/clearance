
const express = require("express");
const morgan = require("morgan");
const dotenv = require("dotenv");
const flash = require('express-flash');
const session = require("express-session");
const mysql = require("mysql");
const passport = require("passport");
const LocalStrategy = require("passport-local").Strategy;
dotenv.config({ path: "config.env" });
const app = express();
const port = 8082;

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
app.use("/login", passportFirst.initialize());
app.use("/login", passportFirst.session());
app.use(flash());

passportFirst.use(
  "local-first",
  new LocalStrategy((username, password, done) => {
    mysqlx.query(
      "SELECT * FROM users WHERE username = ? AND password = ?",
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
    "SELECT * FROM users WHERE username = ?",
    [username],
    (err, results) => {
      if (err) return done(err);
      const user = results[0];

      return done(null, user);
    }
  );
});


app.post("/login", function (req, res, next) {
  passport.authenticate("local-first", function (err, user, info) {
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
      console.log(req.session.username);
      res.redirect("/filter");
    });
  })(req, res, next);
});

app.get("/", function (req, res) {
  res.render("index", { user: req.user });
});


app.get("/login", function (req, res) {
  res.render("login", { message: req.flash("error") });
});


app.get("/filter", ensureAuthenticated, function (req, res) {
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
                      console.log(userId);
                      res.render("filter", {
                        Branches: Branches,
                        Semesters: Semesters,
                        Sessions: Sessions,
                        Sections: Sections,
                        Courses: Courses,
                        user: req.session.username,
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

  console.log(userId);

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
      console.log(query)
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

app.get("/students", authenticate, function (req, res) {
  const userId = req.session.username;
  console.log(userId);

  const Registration_Number = req.session.Registration_Number;
  const Name = req.session.Name;
  const Roll_Number = req.session.Roll_Number;
  const Course = req.session.Course;
  const Branch = req.session.Branch;
  const Semester = req.session.Semester;
  const Section = req.session.Section;
  const Session = req.session.Session;
  const Year = req.session.Year;
  const Mobile_Number = req.session.Mobile_Number;

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

      let query = `SELECT ${selectCols} FROM students WHERE `;
      if (Registration_Number)
        query += " Registration_Number = " + mysql.escape(Registration_Number);
      if (Roll_Number)
        query += " AND Roll_Number = " + mysql.escape(Roll_Number);
      if (Course) query += " Course = " + mysql.escape(Course);
      if (Branch) query += " AND Branch = " + mysql.escape(Branch);
      if (Semester) query += " AND Semester = " + mysql.escape(Semester);
      if (Session) query += " AND Session = " + mysql.escape(Session);
      if (Year) query += " AND Year = " + mysql.escape(Year);
      if (Section) query += " AND Section = " + mysql.escape(Section);
      req.session.returnTo = req.originalUrl;

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
        console.log("students22221");

        console.log(students1);

        res.render("students", {
          students: students1,
          user: userId,
        });
      });
    }
  );
});

function authenticate(req, res, next) {
  if (req.session && req.session.username) {
    return next();
  } else {
    res.redirect("/login");
  }
}

app.get("/back", function (req, res) {
  res.render("filter");
});

app.post("/students/:Registration_Number/verify", function (req, res) {
  const usertable = req.session.username;
  console.log("postingverify");

  // console.log(req.session.username);
  const studentId = req.params.Registration_Number;
  console.log(studentId);
  const queryx = `SELECT user_tablename FROM users WHERE username = "${usertable}"  `;
  mysqlx.query(queryx, function (err, rows, fields) {
    if (err) {
      console.log(err);
      res.status(500).send("Internal Server Error");
      return;
    }
    const usertablename = rows.map((row) => {
      return Object.assign({}, row);
    });
    console.log("lmso");
    console.log(usertablename[0].user_tablename);
    req.session.usertablename = usertablename[0].user_tablename;

    const query = `UPDATE ${req.session.usertablename} SET verification = 1 WHERE Registration_Number = "${studentId}"`;
    console.log(query);
    mysqlx.query(query, [studentId], function (err, rows, fields) {
      if (err) {
        console.log(err);
        res.status(500).send("Internal Server Error");
        return;
      }
      res.redirect("/students");
    });
  });
});

app.post("/students/:Registration_Number/unverify", function (req, res) {
  const usertable = req.session.username;
  console.log(usertable);
  // console.log(req.session.username);
  const studentId = req.params.Registration_Number;
  const queryx = `SELECT user_tablename FROM users WHERE username = "${usertable}"  `;
  mysqlx.query(queryx, function (err, rows, fields) {
    if (err) {
      console.log(err);
      res.status(500).send("Internal Server Error");
      return;
    }
    const usertablename = rows.map((row) => {
      return Object.assign({}, row);
    });
    console.log("unverified");
    console.log(usertablename[0].user_tablename);
    req.session.usertablename = usertablename[0].user_tablename;

    const query = `UPDATE ${req.session.usertablename} SET verification = 0 WHERE Registration_Number = "${studentId}"`;
    console.log(query);
    mysqlx.query(query, function (err, rows, fields) {
      if (err) {
        console.log(err);
        res.status(500).send("Internal Server Error");
        return;
      }
      res.redirect("/students");
    });
  });

});


function ensureAuthenticated(req, res, next) {
  if (req.session.username) {
    console.log(req.session.username);
    return next();
  } else {
    res.redirect("/login");
  }
}

app.listen(port, () => {
  console.log(`server is running`);
});
