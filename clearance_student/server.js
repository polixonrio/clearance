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
const port = 8089;

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

app.use(express.static('public'));



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
  done(null, user.username);
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
      res.redirect("/2studentupdate");
    });
  })(req, res, next);
});



app.get("/2studentupdate", ensureAuthenticated, function (req, res) {
  console.log("req.ses.user ==");
  console.log(req.session.username);
  
  mysqlx.query(
    "SELECT * FROM students WHERE Email = ?",
    [req.session.username],
    function (err, crows, fields) {
      if (err) {
        console.log(err);
        res.status(500).send("Internal Server Error");
        return;
      }
      const scrows = crows.map((row) => {
        return Object.assign({}, row);
      });
      // const scrows = crows.map((row) => row.Branch);
      const mol = scrows[0];
      console.log(mol);

      res.render("2studentupdate", {
        status: scrows[0],
      });
    }
  );
});



// making route to page to generate and download pdf
app.get("/formgenerate",ensureAuthenticated, function (req, res) {
  const userId = req.session.username;
  console.log(userId);

  mysqlx.query(
    "SELECT * FROM students WHERE Email = ?",
    [req.session.username],
    function (err, crows, fields) {
      if (err) {
        console.log(err);
        res.status(500).send("Internal Server Error");
        return;
      }
      const scrows = crows.map((row) => {
        return Object.assign({}, row);
      });
      // const scrows = crows.map((row) => row.Branch);
      const mol = scrows[0];
      console.log(mol);

      res.render("formgenerate", {
        status: scrows[0],
      });
    }
  );
});


app.get("/studentlogin", function (req, res) {
  res.render("studentlogin", { message: req.flash("error") });
});



// app.get("/", function (req, res) {
//   res.render("index", { user: req.user });
// });

app.get("/", function (req, res) {
  res.redirect("/studentlogin");
});

app.get("/logout", function (req, res) {
  req.session.destroy(function (err) {
    // Destroy the session
    if (err) {
      console.log(err);
    }
    res.redirect("/studentlogin"); // Redirect to the login page
  });
});




function ensureAuthenticated(req, res, next) {
  if (req.session.username) {
    console.log(req.session.username);
    return next();
  } else {
    res.redirect("/studentlogin");
  }
}

app.listen(port, () => {
  console.log(`server is running`);
});
