package ogg;

import haxe.io.BytesData;

//:notes:
//  :skipped: functions are unfitting to haxe workflow
//  :future: functions that are tertiary
//  :todo: functions that are needed to be exposed

@:keep
@:include('linc_ogg.h')
@:build(linc.Touch.apply())
extern class Ogg {

    //:todo: static function ov_open_callbacks(void *datasource, OggVorbis_File *vf, const char *initial, long ibytes, ov_callbacks callbacks) : Int;
    @:native('linc::ogg::ov_open_callbacks')
    static function ov_open_callbacks(src:BytesData, file:OggVorbisFile, initial:BytesData, ibytes:Int, callbacks:OggCallbacks) : Int;

    //ret long, ,int *bitstream at the end is left
    @:native('linc::ogg::ov_read')
    static function ov_read(vf:OggVorbisFile, buffer:BytesData, length:Int, endian:OggEndian, word:OggWord, sgned:OggSigned) : Int;

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

    //:future: long ov_read_filter(OggVorbis_File *vf, char *buffer, int length, int bigendianp, int word, int sgned, int *bitstream, void (*filter)(float **pcm,long channels,long samples,void *filter_param),void *filter_param);
    //:future: long ov_read_float(OggVorbis_File *vf, float ***pcm_channels, int samples, int *bitstream);

    //:skipped: static function ov_open(FILE *f, vf:OggVorbisFile, ibytes:Int) : Int; //ibytes=long
    //:skipped: static function ov_test(FILE *f,OggVorbis_File *vf,const char *initial,long ibytes) : Int;
    //:skipped: static function ov_test_callbacks(void *datasource, OggVorbis_File *vf, const char *initial, long ibytes, ov_callbacks callbacks) : Int;
    //:skipped: @:native('ov_test_open') static function ov_test_open(vf:OggVorbisFile) : OggCode;

} //Ogg

//userdata,size,nmemb,data
typedef OggReadFN = Dynamic->Int->Int->BytesData->Int;
//userdata,offset,whence
typedef OggSeekFN = Dynamic->haxe.Int64->OggWhence->Int;
//userdata
typedef OggCloseFN = Dynamic->Int;
//userdata
typedef OggTellFN = Dynamic->Int;

typedef OggCallbacks = {
    var read_fn: OggReadFN;
    var seek_fn: OggSeekFN;
    var close_fn: OggCloseFN;
    var tell_fn: OggTellFN;
}

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

typedef VorbisComment = {
    vendor:String,
    comments:Array<String>
}

@:enum
abstract OggWhence(Int) from Int to Int {
    var OGG_SEEK_SET = 0;
    var OGG_SEEK_CUR = 1;
    var OGG_SEEK_END = 2;
}

@:enum
abstract OggWord(Int) from Int to Int {
    var TYPICAL = 2;
    var OGG_8_BIT = 1;
    var OGG_16_BIT = 2;
}

@:enum
abstract OggSigned(Int) from Int to Int {
    var TYPICAL = 1;
    var OGG_UNSIGNED = 0;
    var OGG_SIGNED = 1;
}

@:enum
abstract OggEndian(Int) from Int to Int {
    var TYPICAL = 0;
    var OGG_L_ENDIAN = 0;
    var OGG_B_ENDIAN = 1;
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
