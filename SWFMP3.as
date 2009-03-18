import com.bomberstudios.utils.Delegate;

class SWFMP3 {
  var tl:MovieClip;
  var so:Sound;
  var playing:Boolean = false;
  var load_complete:Boolean = false;
  var refresh_ui_interval:Number;
  var refresh_ui_rate:Number = 100;

  function SWFMP3(timeline){
    tl = timeline;
    Stage.scaleMode = "noScale";
    Stage.align = "TL";
    Stage.addListener(this);
    draw();
    refresh_ui();
  }

  /* Events */
  function on_sound_loaded(){
    load_complete = true;
  }
  function onResize(){
    refresh_ui();
  }

  /* Control */
  function toggle_play(){
    if (!playing) {
      if (tl.mp3_file) {
        update_sound(tl.mp3_file);
      } else {
        update_sound("test.mp3");
      }

      tl.buttons.play.attachMovie("btn_pause","play",1);
      tl.buttons.play.onRollOver = function(){
        this.attachMovie("btn_pause_over","play",1);
      }
      tl.buttons.play.onRollOut = function(){
        this.attachMovie("btn_pause","play",1);
      }
      so.start();
    } else {
      tl.buttons.play.attachMovie("btn_play","play",1);
      tl.buttons.play.onRollOver = function(){
        this.attachMovie("btn_play_over","play",1);
      }
      tl.buttons.play.onRollOut = function(){
        this.attachMovie("btn_play","play",1);
      }
      so.stop();
    }
    playing = !playing;
  }
  function update_sound(file){
    so = new Sound();
    so.onLoad = Delegate.create(this,on_sound_loaded);
    so.loadSound(file, true);
    refresh_ui_interval = setInterval(Delegate.create(this,refresh_ui),100);
  }

  /* Progress Bar */
  function update_play_bar(){
    tl.bar.playbar._width = (so.position / so.duration)*tl.bar.loadbar._width;
  }
  function update_load_bar(){
    tl.bar.loadbar._width = (so.getBytesLoaded() / so.getBytesTotal())*Stage.width - 4;
  }

  private function draw(){
    // Background
    tl.createEmptyMovieClip("back",1);
    tl.back.attachMovie("bg","bg",1);

    // Play/Progress bar
    tl.createEmptyMovieClip("bar",2);
    tl.bar.attachMovie("bg_loadbar","loadbar",1);
    tl.bar.attachMovie("bg_playbar","playbar",2);
    tl.bar.loadbar._height = tl.back._height - 4;
    tl.bar.loadbar._width = 1;
    tl.bar.loadbar._y = 2;
    tl.bar.loadbar._x = 2;
    tl.bar.playbar._height = tl.back._height - 4;
    tl.bar.playbar._width = 1;
    tl.bar.playbar._y = 2;
    tl.bar.playbar._x = 2;

    // Buttons
    tl.createEmptyMovieClip("buttons",3);
    tl.buttons.attachMovie("btn_play","play",1);
    tl.buttons.play.onRollOver = function(){
      this.attachMovie("btn_play_over","play",1);
    }
    tl.buttons.play.onRollOut = function(){
      this.attachMovie("btn_play","play",1);
    }
    tl.buttons.play.onRelease = Delegate.create(this,toggle_play);

  }
  private function refresh_ui(){
    tl.back.bg._width = Stage.width;
    update_play_bar();
    update_load_bar();
  }
  static function main(tl:MovieClip){
    var app:SWFMP3 = new SWFMP3(tl);
  }
}
