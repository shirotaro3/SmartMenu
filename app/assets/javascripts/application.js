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
//= require jquery.jpostal 
//= require_tree ../../../vendor/assets/javascripts/.
//= require_tree .
document.addEventListener("turbolinks:load", function() {
     
    // フラッシュメッセージ アニメーション
	$('#flash-message').fadeIn("slow", function () {
		$(this).delay(2300).fadeOut("", function(){
            $('#error-message').fadeIn("");
        });
    });
    $('#error-close-btn').on('click', function(){
        $('#error-message').fadeOut('fast');
    });

    // メニューボタン1(センター)
    $('#menu-btn1').on('click',function(){
        // メニュー展開中にもう一方のメニューを開こうとした時
        if($('#mypage-menu-modal').is(':visible')){
            $('#menu-btn2').removeClass('is-pushed');
            $('#mypage-menu-modal').fadeOut('fast');
        }else{
            $('#menu-overlay').fadeToggle(170);
        }
        $(this).toggleClass('is-pushed');
        $('#menu-modal').fadeToggle(170);
    });

    // メニューボタン2(マイページ)
    $('#menu-btn2').on('click',function(){
        // メニュー展開中にもう一方のメニューを開こうとした時
        if($('#menu-modal').is(':visible')){
            $('#menu-btn1').removeClass('is-pushed');
            $('#menu-modal').fadeOut('fast');
        }else{
            $('#menu-overlay').fadeToggle(170);
        }
        $(this).toggleClass('is-pushed');
        $('#mypage-menu-modal').fadeToggle(170);
    });

    // メニューボタン3(ユーザー)
    $('#menu-btn3').on('click',function(){
        $(this).toggleClass('is-pushed');
        $('#menu-overlay').fadeToggle(170);
    });

    // メニュー外クリックでメニュー非表示
    $('#menu-overlay').on('click',function(){
        $('#menu-btn1,#menu-btn2,#menu-btn3').removeClass('is-pushed');
        $(this).fadeOut('fast',function(){
            $('#menu-modal,#mypage-menu-modal').hide();
        });
    });

    // メニュー内クリックでは閉じないように
    $('.menu-list').on('click',function(event){
        event.stopPropagation();
    });

    // スクロールボタン
	$('#back-to-top').on('click', function(){
		$('html').animate({scrollTop: 0},300,function(){
            // scrollTopがsafariで動作しないため追加
            window.location.href = '#top';
		});
    });

    // inputtype-fileのパス表示
    $(document).on('change', ':file', function() {
        var input = $(this),
        numFiles = input.get(0).files ? input.get(0).files.length : 1,
        // パスを書き換え
        label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
        input.parent().parent().next(':text').val(label);
    });


    // inputtype-fileのプレビュー表示
    $(function(){
        //画像ファイルプレビュー表示のイベント追加 fileを選択時に発火するイベントを登録
        $('form').on('change', 'input[type="file"]', function(e) {
          var file = e.target.files[0],
              reader = new FileReader(),
              $preview = $(".preview");
              t = this;
      
          // 画像ファイル以外の場合は何もしない
          if(file.type.indexOf("image") < 0){
            return false;
          }
      
          // ファイル読み込みが完了した際のイベント登録
          reader.onload = (function(file) {
            $('.images').hide();
            return function(e) {
              //既存のプレビューを削除
              $preview.empty();
              // .prevewの領域の中にロードした画像を表示するimageタグを追加
              $preview.append($('<img>').attr({
                        src: e.target.result,
                        width: "150px",
                        class: "preview",
                        title: file.name
                    }));
            };
          })(file);
      
          reader.readAsDataURL(file);
        });
      });

    // オプションを指定してSkipprの実行
    $("#theTarget").skippr({
        // スライドショーの変化 ("fade" or "slide")
        transition : 'slide',
        // 変化に係る時間(ミリ秒)
        speed : 1000,
        // easingの種類
        easing : 'easeOutQuart',
        // ナビゲーションの形("block" or "bubble")
        navType : 'block',
        // 子要素の種類("div" or "img")
        childrenElementType : 'div',
        // ナビゲーション矢印の表示(trueで表示)
        arrows : false,
        // スライドショーの自動再生(falseで自動再生なし)
        autoPlay : true,
        // 自動再生時のスライド切替間隔(ミリ秒)
        autoPlayDuration : 4000,
        // キーボードの矢印キーによるスライド送りの設定(trueで有効)
        keyboardOnAlways : true,
        // 一枚目のスライド表示時に戻る矢印を表示するかどうか(falseで非表示)
        hidePrevious : false
    });

});