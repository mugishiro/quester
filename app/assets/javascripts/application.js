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
//= require_tree .
//= require jquery
//= require jquery_ujs

$(function (){
  // 処理（ページが読み込まれた時、フォームに残り何文字入力できるかを数えて表示する）
  var max = 500;
  //フォームに入力されている文字数を数える
  //\nは"改行"に変換して2文字にする。オプションフラグgで文字列の最後まで\nを探し変換する
  var count = $(".js-text").text().replace(/\n/g, "改行").length;
  //残りの入力できる文字数を計算
  var now_count = max - count;
  //文字数がオーバーしていたら文字色を赤にする
  if (count > max) {
    $(".js-text-count").css("color","red");
  }
  //残りの入力できる文字数を表示
  $(".js-text-count").text( "残り" + now_count + "文字");

  $(".js-text").on("keyup", function() {
    // 処理（キーボードを押した時、フォームに残り何文字入力できるかを数えて表示する）
    //フォームのvalueの文字数を数える
    var count = $(this).val().replace(/\n/g, "改行").length;
    var now_count = max - count;

    if (count > max) {
      $(".js-text-count").css("color","red");
    } else {
      $(".js-text-count").css("color","black");
    }
    $(".js-text-count").text( "残り" + now_count + "文字");
  });
});
