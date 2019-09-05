// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery
//= require jquery_ujs
//= require chartkick
//= require Chart.bundle
//= require_tree ../../../vendor/assets/javascripts/.
//= require_tree .
document.addEventListener("turbolinks:load", function() {
     
    // フラッシュメッセージ　アニメーション
	$('#flash-message').fadeIn("slow", function () {
		$(this).delay(3000).fadeOut("slow");
    });
    
    // メニュー表示
    $('#menu-btn1').on('click',function(){
        $(this).toggleClass('is-pushed');
        $('#menu-overlay').fadeToggle(170);
    });

    // メニュー外クリックでメニュー非表示
    $('#menu-overlay').on('click',function(){
        $('#menu-btn1').removeClass('is-pushed');
        $(this).fadeOut('fast');
    });

    // メニュー内クリックでは閉じないように（伝播）
    $('.menu-list').on('click',function(event){
        event.stopPropagation();
    })





});