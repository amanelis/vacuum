// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require lib/encapsulatedPlugin
//= require lib/toggle

$(document).ready(function() {

  $(document).foundation()

  // Notifications form validation
	$('#notifications_form').submit(function(evt) {
    evt.preventDefault();
		$('#notification_name').removeClass('error');
		$('#notification_email').removeClass('error');
		$('#notifications_name_error').empty();
		$('#notifications_email_error').empty();

	  var error = false;
		var name  = $('#notification_name').val();
		var email = $('#notification_email').val();
		var project_id = $('#notification_project_id').val();

		if (name == '' || name == null || name == undefined) {
			$('#notification_name').addClass('error');
			$('#notifications_name_error').html('<div class="alert-box alert">Add a name<a href="" class="close">&times;</a></div>');
			error = true;
		}
		if (email == '' || email == null || email == undefined) {
			$('#notification_email').addClass('error');
			$('#notifications_email_error').html('<div class="alert-box alert">Add an email<a href="" class="close">&times;</a></div>');
			error = true;
		}

		if (error) {
			return false;
		} else {
		  this.submit();
		}
	});

	// Collaborators form validation
	$('#collaborators_form').submit(function(evt) {
    evt.preventDefault();
  	$('#collaborator_email').removeClass('error');
  	$('#collaborators_email_error').empty();

    var error = false;
  	var email = $('#collaborator_email').val();
  	var project_id = $('#collaborator_project_id').val();

  	if (email == '' || email == null || email == undefined) {
  		$('#collaborator_email').addClass('error');
  		$('#collaborators_email_error').html('<div class="alert-box alert">Add an email<a href="" class="close">&times;</a></div>');
  		error = true;
  	}

  	if (error) {
  		return false;
  	} else {
      this.submit();
  	}
  });

	// Text area for script tag, auto highlight
	$('textarea#codebox').click(function() {
	  this.focus();
	  this.select();
	});
});