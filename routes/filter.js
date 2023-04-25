

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



router.get("/", function (req, res) {
    const userId = req.query.username;
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
  
        // Retrieve departments from the departments table
        mysqlx.query(
          "SELECT DISTINCT Course FROM students",
          function (err, courseRows, fields) {
            if (err) {
              console.log(err);
              res.status(500).send("Internal Server Error");
              return;
            }
  
            const Courses = courseRows.map((row) => row.semester);
  
            // Retrieve semesters from the semesters table
            mysqlx.query(
              "SELECT DISTINCT Semester FROM students",
              function (err, semRows, fields) {
                if (err) {
                  console.log(err);
                  res.status(500).send("Internal Server Error");
                  return;
                }
  
                const Semesters = semRows.map((row) => row.department);
  
                // Retrieve sections from the sections table
                mysqlx.query(
                  "SELECT DISTINCT Session FROM students",
                  function (err, sesRows, fields) {
                    if (err) {
                      console.log(err);
                      res.status(500).send("Internal Server Error");
                      return;
                    }
  
                    const Sessions = sesRows.map((row) => row.section);
  
                    mysqlx.query(
                      "SELECT DISTINCT Section FROM students",
                      function (err, secRows, fields) {
                        if (err) {
                          console.log(err);
                          res.status(500).send("Internal Server Error");
                          return;
                        }
  
                        const Sections = secRows.map((row) => row.section);
  
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
  module.exports = router;