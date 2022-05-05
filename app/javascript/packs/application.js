// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "bootstrap";

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "../stylesheets/application"
const images = require.context('../images', true)

//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-typeahead-rails
//= require_tree .

var ready = function() {
  var engine = new Bloodhound({
      datumTokenizer: function(d) {
          console.log(d);
          return Bloodhound.tokenizers.whitespace(d.title);
      },
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      remote: {
          url: '../search/typeahead/%QUERY'
      }
  });

  var promise = engine.initialize();

  promise
      .done(function() { console.log('success'); })
      .fail(function() { console.log('error') });

  $("#term").typeahead(null, {
    name: "post",
    displayKey: "title",
    source: engine.ttAdapter()
  })
};

$(document).ready(ready);
$(document).on('page:load', ready);
