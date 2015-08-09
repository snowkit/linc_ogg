package ogg;

import haxe.io.BytesData;

@:include('linc_ogg.h')
@:native('OggVorbis_File')
private extern class OggVorbisFile_ex {}
typedef OggVorbisFile = cpp.Pointer<OggVorbisFile_ex>;

@:keep
@:include('linc_ogg.h')
@:build(linc.Touch.apply())
extern class Ogg {

    static function ov_clear(vf:OggVorbisFile) : Int;
    static function ov_fopen(path:String, vf : OggVorbisFile) : Int;

    //:todo: static function ov_open(FILE *f, vf:OggVorbisFile, ibytes:Int) : Int; //ibytes=long
    //:todo: static function ov_test(FILE *f,OggVorbis_File *vf,const char *initial,long ibytes) : Int;

    // static function ov_open_callbacks(void *datasource, OggVorbis_File *vf, const char *initial, long ibytes, ov_callbacks callbacks) : Int;
    // static function ov_test_callbacks(void *datasource, OggVorbis_File *vf, const char *initial, long ibytes, ov_callbacks callbacks) : Int;

    static function ov_test_open(vf:OggVorbisFile) : Int;
    static function ov_bitrate(vf:OggVorbisFile,i:Int) : Int; //ret long
    static function ov_bitrate_instant(vf:OggVorbisFile) : Int; //ret long
    static function ov_streams(vf:OggVorbisFile) : Int; //ret long
    static function ov_seekable(vf:OggVorbisFile) : Int; //ret long
    static function ov_serialnumber(vf:OggVorbisFile,i:Int) : Int; //ret long
    static function ov_raw_total(vf:OggVorbisFile,i:Int) : haxe.Int64;
    static function ov_pcm_total(vf:OggVorbisFile,i:Int) : haxe.Int64;
    static function ov_time_total(vf:OggVorbisFile,i:Int) : Float; //double
    static function ov_read(vf:OggVorbisFile, buffer:BytesData, length:Int, bigendianp:Int,word:Int,sgned:Int) : Int; //ret long, ,int *bitstream at the end is left
    static function ov_halfrate(vf:OggVorbisFile,flag:Int) : Int;
    static function ov_halfrate_p(vf:OggVorbisFile) : Int;

} //Ogg

@:buildXml("<include name='${haxelib:linc_ogg}/linc/linc_ogg.xml'/>")
@:keep private class OggLinc {}
