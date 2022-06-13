// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require jquery-ui
//= require filterrific/filterrific-jquery

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "bootstrap";

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "../stylesheets/application.scss"
const images = require.context('../images', true)

$(document).ready( function() {
$('.dropdown-menu').dropdown();
});

var cat_route = document.getElementById("cat_route");
var subdir = document.getElementById("subdir");
var route = document.getElementById("route");
var city = document.getElementById("city");
var name = document.getElementById("name");
var link = document.getElementById("link");
var category = document.getElementById("category");
var content = document.getElementById("content");
var price = document.getElementById("price");
function getResult() {
  subdir.classList.add("hidden"); {
    if(cat_route == "Услуга");
  }
  result.classList.remove("hidden");
}
