// routes/thoughts.js

const axios = require("axios");
const express = require("express");

const bodyParser = require("body-parser");
const router = express.Router();

const backendUrlBase =
  "https://cloudx-backend-app-820548440a04bd6e.azurewebsites.net";
const appTitle = "Thoughts App";
let thoughts = ["Thought 1", "Thought 2", "Thought 3"]; // This data typically comes from your database.

router.use(bodyParser.urlencoded({ extended: false }));
router.use(bodyParser.json());

router.get("/", function (req, res) {
  axios
    .get(`${backendUrlBase}/thoughts`)
    .then(function (response) {
      req.session.justPosted = false;
      const thoughts =
        response.data.length > 0
          ? response.data.map((thought) => thought.thought).reverse()
          : ["Hey, no thoughts stored yet!"];
      res.render("index", { thoughts: thoughts, title: appTitle,  justPosted: req.session.justPosted });
    })
    .catch(function (error) {
      req.session.justPosted = false;
      console.log(error);
      res.render("index", {
        thoughts: ["Hey, no thoughts stored yet!"],
        title: appTitle,
        justPosted: req.session.justPosted,
      });
    });
});

router.post("/", function (req, res) {
  let newThought = req.body.content;
  thoughts.push(newThought);
  console.log(newThought);
  axios
    .post(`${backendUrlBase}/thoughts`, {
      thought: newThought,
    })
    .then(function(response) {
      console.log(response.data);
      req.session.justPosted = true;
      res.redirect('/');
    })
    .catch(function(error) {
      console.log(error);
      res.redirect('/');
    });

  // res.redirect('/');
});

module.exports = router;
