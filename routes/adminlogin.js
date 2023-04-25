

const express = require("express");
const morgan = require("morgan");
const dotenv = require("dotenv");
const flash = require("express-flash");
const session = require("express-session");

const router = express.Router();

const mysql = require("mysql");
const passport = require("passport");
const LocalStrategy = require("passport-local").Strategy;
dotenv.config({ path: "config.env" });
const path = require("path");



router.use(session({ cookie: { maxAge: 60000 }, 
    secret: 'woot',
    resave: false, 
    saveUninitialized: false}));

const passportSecond = require("passport");
router.use("/adminlogin", passportSecond.initialize());
router.use("/adminlogin", passportSecond.session());
router.use(flash());



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



passportSecond.use(
  "local-second",
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

// Configure Passport serializer/deserializer functions for second view
passportSecond.serializeUser((user, done) => {
  done(null, user.id);
});

passportSecond.deserializeUser((id, done) => {
  mysqlx.query(
    "SELECT * FROM adminusers WHERE id = ?",
    [id],
    (err, results) => {
      if (err) return done(err);
      const user = results[0];
      return done(null, user);
    }
  );
});

router.post("/", function (req, res, next) {
  passport.authenticate("local-second", function (err, user, info) {
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

router.get("/", function (req, res) {
    res.render("adminlogin", { message: req.flash("error") });
  });

  module.exports = router;