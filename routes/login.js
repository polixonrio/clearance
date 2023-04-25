// const express = require("express");
// const morgan = require("morgan");
// const dotenv = require("dotenv");
// const flash = require("express-flash");
// const session = require("express-session");

// const router = express.Router();

// const mysql = require("mysql");
// const passport = require("passport");
// const LocalStrategy = require("passport-local").Strategy;
// dotenv.config({ path: "config.env" });
// const path = require("path");

// router.use(
//   session({
//     cookie: { maxAge: 60000 },
//     secret: "woot",
//     resave: false,
//     saveUninitialized: false,
//   })
// );

// router.use(flash());

// let mysqlx = mysql.createConnection({
//   host: "localhost",
//   user: "root",
//   password: "",
//   database: "clearance",
// });

// mysqlx.connect((err) => {
//   if (!err) {
//     console.log("db connection successful login route");
//   } else {
//     console.log("db connection failed" + JSON.stringify(err, undefined, 2));
//   }
// // });

// router.use(passport.initialize());
// router.use(passport.session());
// router.use(flash());

// passport.use(
//   "login",
//   new LocalStrategy(function (username, password, done) {
//     console.log("LocalStrategy is executing...");

//     mysqlx.query(
//       "SELECT * FROM users WHERE username = ?",
//       [username],
//       function (err, rows, fields) {
//         console.log(rows[0]);
//         if (err) {
//           return done(err);
//         }
//         if (!rows.length) {
//           return done(null, false, { message: "Incorrect username." });
//         }
//         if (rows[0].password != password) {
//           return done(null, false, { message: "Incorrect password." });
//         }
//         console.log(rows[0]);
//         return done(null, rows[0]);
//       }
//     );
//   })
// );

// passport.serializeUser(function (user, done) {
//   done(null, user.ID);
// });

// passport.deserializeUser(function (id, done) {
//   mysqlx.query(
//     "SELECT * FROM users WHERE id = ?",
//     [id],
//     function (err, rows, fields) {
//     console.log("rows[0]");
//       done(err, rows[0]);
//     }
//   );
// });

// router.get("/", function (req, res) {
//   res.render("login");
// });

// router.post("/", function (req, res, next) {
//   console.log("Authenticating user...");

//   passport.authenticate("login", function (err, user, info) {
//     if (err) {
//       return next(err);
//     }
//     if (!user) {
//       req.flash("error", info.message);
//       console.log("fuck");
//       return res.redirect("/login");
//     }
//     req.logIn(user, function (err) {
//       if (err) {
//         return next(err);
//       }
//       res.redirect(`/filter?username=${req.user.username}`);
//     });
//   })(req, res, next);
// });


// router.post("/", function (req, res, next) {
//     console.log("Authenticating user...");
//     passport.authenticate("login", function (err, user, info) {
//       if (err) {
//         return next(err);
//       }
//       if (!user) {
//         req.flash("error", info.message);
//         console.log("Authentication failed");
//         return res.redirect("/login");
//       }
//       req.logIn(user, function (err) {
//         if (err) {
//           return next(err);
//         }
//         res.redirect(`/filter?username=${req.user.username}`);
//       });
//     })(req, res, next);
//   });
  

// module.exports = router;

















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

const passport2 = require("passport");
router.use("/login", passport2.initialize());
router.use("/login", passport2.session());
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



passport2.use(
  "local-second",
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

// Configure Passport serializer/deserializer functions for second view
passport2.serializeUser((user, done) => {
  done(null, user.id);
});

passport2.deserializeUser((id, done) => {
  mysqlx.query(
    "SELECT * FROM users WHERE id = ?",
    [id],
    (err, results) => {
      if (err) return done(err);
      const user = results[0];
      return done(null, user);
    }
  );
});



router.post("/", function (req, res, next) {
    console.log("Authenticating user...");
    passport.authenticate("local-second", function (err, user, info) {
      if (err) {
        return next(err);
      }
      if (!user) {
        req.flash("error", info.message);
        console.log("Authentication failed");
        return res.redirect("/login");
      }
      req.logIn(user, function (err) {
        if (err) {
          return next(err);
        }
        res.redirect(`/filter?username=${req.user.username}`);
      });
    })(req, res, next);
  });
  


router.get("/", function (req, res) {
    res.render("login", { message: req.flash("error") });
  });

  module.exports = router;