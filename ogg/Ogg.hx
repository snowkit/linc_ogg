package ogg;

import haxe.io.BytesData;

//:notes:
//  :skipped: functions are unfitting to haxe workflow, but could be exposed still

@:keep
@:include('linc_ogg.h')
@:build(linc.Touch.apply())
extern class Ogg {

    //:todo: static function ov_open_callbacks(void *datasource, OggVorbis_File *vf, const char *initial, long ibytes, ov_callbacks callbacks) : Int;
    //:todo: static function ov_test_callbacks(void *datasource, OggVorbis_File *vf, const char *initial, long ibytes, ov_callbacks callbacks) : Int;

    //ret long, ,int *bitstream at the end is left
    // @:native('linc::ogg::ov_read')
    //:todo: static function ov_read(vf:OggVorbisFile, buffer:BytesData, length:Int, bigendianp:Int, word:Int, sgned:Int) : Int;

    @:native('linc::ogg::newOggVorbisFile')
    static function newOggVorbisFile() : OggVorbisFile;

    @:native('ov_clear')
    static function ov_clear(vf:OggVorbisFile) : Int;

    @:native('ov_fopen')
    static function ov_fopen(path:String, vf : OggVorbisFile) : Int;

    @:native('ov_info')
    static function ov_info(vf:OggVorbisFile,link:Int) : VorbisInfo;

    @:native('linc::ogg::ov_comment')
    static function ov_comment(vf:OggVorbisFile,link:Int) : VorbisComment;

    @:native('ov_test_open')
    static function ov_test_open(vf:OggVorbisFile) : OggCode;

    @:native('ov_bitrate')
    static function ov_bitrate(vf:OggVorbisFile,i:Int) : Int; //ret long

    @:native('ov_bitrate_instant')
    static function ov_bitrate_instant(vf:OggVorbisFile) : Int; //ret long

    @:native('ov_streams')
    static function ov_streams(vf:OggVorbisFile) : Int; //ret long

    @:native('ov_seekable')
    static function ov_seekable(vf:OggVorbisFile) : Int; //ret long

    @:native('ov_serialnumber')
    static function ov_serialnumber(vf:OggVorbisFile,i:Int) : Int; //ret long

    @:native('ov_raw_total')
    static function ov_raw_total(vf:OggVorbisFile,i:Int) : haxe.Int64;

    @:native('ov_pcm_total')
    static function ov_pcm_total(vf:OggVorbisFile,i:Int) : haxe.Int64;

    @:native('ov_time_total')
    static function ov_time_total(vf:OggVorbisFile,i:Int) : Float; //double

    @:native('ov_halfrate')
    static function ov_halfrate(vf:OggVorbisFile,flag:Int) : Int;

    @:native('ov_halfrate_p')
    static function ov_halfrate_p(vf:OggVorbisFile) : Int;

    @:native('ov_raw_tell')
    static function ov_raw_tell(vf:OggVorbisFile) : haxe.Int64;

    @:native('ov_pcm_tell')
    static function ov_pcm_tell(vf:OggVorbisFile) : haxe.Int64;

    @:native('ov_time_tell')
    static function ov_time_tell(vf:OggVorbisFile) : Float;

    @:native('ov_raw_seek')
    static function ov_raw_seek(vf:OggVorbisFile, pos:haxe.Int64) : OggCode;

    @:native('ov_pcm_seek')
    static function ov_pcm_seek(vf:OggVorbisFile, pos:haxe.Int64) : OggCode;

    @:native('ov_pcm_seek_page')
    static function ov_pcm_seek_page(vf:OggVorbisFile, pos:haxe.Int64) : OggCode;

    @:native('ov_time_seek')
    static function ov_time_seek(vf:OggVorbisFile, pos:Float) : OggCode; //pos double

    @:native('ov_time_seek_page')
    static function ov_time_seek_page(vf:OggVorbisFile, pos:Float) : OggCode; //pos double

    @:native('ov_raw_seek_lap')
    static function ov_raw_seek_lap(vf:OggVorbisFile, pos:haxe.Int64) : OggCode;

    @:native('ov_pcm_seek_lap')
    static function ov_pcm_seek_lap(vf:OggVorbisFile, pos:haxe.Int64) : OggCode;

    @:native('ov_pcm_seek_page_lap')
    static function ov_pcm_seek_page_lap(vf:OggVorbisFile, pos:haxe.Int64) : OggCode;

    @:native('ov_time_seek_lap')
    static function ov_time_seek_lap(vf:OggVorbisFile, pos:Float) : OggCode; //pos double

    @:native('ov_time_seek_page_lap')
    static function ov_time_seek_page_lap(vf:OggVorbisFile, pos:Float) : OggCode; //pos double

    //:skipped: static function ov_open(FILE *f, vf:OggVorbisFile, ibytes:Int) : Int; //ibytes=long
    //:skipped: static function ov_test(FILE *f,OggVorbis_File *vf,const char *initial,long ibytes) : Int;

} //Ogg

@:include('linc_ogg.h')
@:native('OggVorbis_File')
private extern class EOggVorbisFile {}
typedef OggVorbisFile = cpp.Pointer<EOggVorbisFile>;

@:include('linc_ogg.h')
@:native('vorbis_info*')
extern class VorbisInfo {
    var version:Int;
    var channels:Int;
    var rate:Int;
    var bitrate_upper:Int;
    var bitrate_nominal:Int;
    var bitrate_lower:Int;
    var bitrate_window:Int;
}
// typedef VorbisInfo = cpp.Pointer<EVorbisInfo>;

typedef VorbisComment = {
    vendor:String,
    comments:Array<String>
}

@:enum
abstract OggCode(Int) from Int to Int {
    var OV_FALSE        = -1;
    var OV_EOF          = -2;
    var OV_HOLE         = -3;

    var OV_EREAD        = -128;
    var OV_EFAULT       = -129;
    var OV_EIMPL        = -130;
    var OV_EINVAL       = -131;
    var OV_ENOTVORBIS   = -132;
    var OV_EBADHEADER   = -133;
    var OV_EVERSION     = -134;
    var OV_ENOTAUDIO    = -135;
    var OV_EBADPACKET   = -136;
    var OV_EBADLINK     = -137;
    var OV_ENOSEEK      = -138;
}


@:buildXml("<include name='${haxelib:linc_ogg}/linc/linc_ogg.xml'/>")
@:keep private class OggLinc {}
