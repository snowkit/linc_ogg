
import haxe.io.Bytes;
import haxe.io.BytesData;
import ogg.Ogg;

import sys.io.File;


typedef FileInfo = { file:sys.io.FileInput, id:Int };

class Test {

    static function main() {

        // for(i in 0 ... 20) {
        //     trace('waiting ${20 - i} seconds for debugging...');
        //     Sys.sleep(1);
        // }


        var file:OggVorbisFile = Ogg.newOggVorbisFile();

        trace('open: ' + code(Ogg.ov_fopen('sound.ogg', file)));

        var info = Ogg.ov_info(file,-1);

        trace('version: '+Std.int(info.version));
        trace('serial: '+Std.int(Ogg.ov_serialnumber(file,-1)));
        trace('seekable: '+Std.int(Ogg.ov_seekable(file)));
        trace('streams: '+Std.int(Ogg.ov_streams(file)));
        trace('rate: '+Std.int(info.rate));
        trace('channels: '+Std.int(info.channels));

        trace('pcm: '+Std.string( Ogg.ov_pcm_total(file,-1) ));
        trace('raw: '+Std.string( Ogg.ov_raw_total(file,-1) ));
        trace('time: '+Std.string( Ogg.ov_time_total(file,-1) ));

        trace('ov_bitrate: ' + code(Ogg.ov_bitrate(file, -1)));
        trace('ov_bitrate_instant: ' + code(Ogg.ov_bitrate_instant(file)));
        trace('bitrate_lower: '+Std.int(info.bitrate_lower));
        trace('bitrate_nominal: '+Std.int(info.bitrate_nominal));
        trace('bitrate_upper: '+Std.int(info.bitrate_upper));
        trace('bitrate_window: '+Std.int(info.bitrate_window));

        trace('pcm tell: '+code( cast Ogg.ov_pcm_tell(file) ));
        trace('raw tell: '+code( cast Ogg.ov_raw_tell(file) ));
        trace('time tell: '+code( cast Ogg.ov_time_tell(file) ));

        var comment = Ogg.ov_comment(file,-1);

        trace('vendor: ' + comment.vendor);
        for(c in comment.comments) {
            trace('  ' + c);
        }

        //bytes_read = ov_read(&vf, buffer, 4096,0,2,1,&current_section)
        var buffer = haxe.io.Bytes.alloc(128);
        var bytes_read = Ogg.ov_read(file, buffer.getData(), 128, OggEndian.TYPICAL, OggWord.TYPICAL, OggSigned.TYPICAL);

        trace('read: ' + code(bytes_read));
        trace('128 bytes:\n' + str128(buffer));
        trace('clear: ' + code(Ogg.ov_clear(file)));

        test_callbacks();

    }

    static function str128(bytes:haxe.io.Bytes) {
        var c = Std.int(Math.min(128, bytes.length));
        var s = '';
        for( i in 0 ... c ) {
            s += '0x'+StringTools.hex(bytes.get(i));
            if(i > 0 && i % 32 == 0) s += '\n'; else
            if(i < c-1) s += ' ';
        }
        return s;
    }

    static function test_callbacks() {

        trace('test_callbacks');

        var file:OggVorbisFile = Ogg.newOggVorbisFile();
        var input = sys.io.File.read('sound.ogg', true);

        input.seek(0,SeekEnd);
        var p = input.tell();
        input.seek(0,SeekBegin);

        trace('file size is $p');

        var res = Ogg.ov_open_callbacks({id:1, file:input}, file, null, 0, {
            read_fn:oread, seek_fn:oseek, close_fn:oclose, tell_fn:otell
        });

        trace('ov_open_callbacks ' + code(res));
        trace('about to read a block of 128 bytes');

        var buffer = haxe.io.Bytes.alloc(128);
        var bytes_read = Ogg.ov_read(file, buffer.getData(), 128, OggEndian.TYPICAL, OggWord.TYPICAL, OggSigned.TYPICAL);

        trace('read: ' + code(bytes_read));
        trace('128 bytes:\n' + str128(buffer));
        trace('clear: ' + code(Ogg.ov_clear(file)));

    } //test_callbacks

    static function oread(userdata:FileInfo, size:Int, count:Int, data:BytesData):Int {

        trace('oread cb:${userdata.id} size:$size, count:$count data length:${data.length}');

        var b = haxe.io.Bytes.ofData(data);
        var p = userdata.file.tell();
        var t = size*count;
        var l = t;
        for(i in 0 ... t) {
            try {
                b.set(i, userdata.file.readByte());
            } catch(e:Dynamic) {
                l = i-1;
            }
        }

        // var l = userdata.file.readBytes(b, p, t);

        trace('   didread $l bytes from pos:$p for length:${size*count}');

        return l;

    }

    static function oseek(userdata:FileInfo,offset:Int,whence:OggWhence):Void {
        trace('oseek cb:${userdata.id} offset:$offset whence:$whence');
        var _w = switch(whence) {
            case OggWhence.OGG_SEEK_CUR: sys.io.FileSeek.SeekCur;
            case OggWhence.OGG_SEEK_END: sys.io.FileSeek.SeekEnd;
            case OggWhence.OGG_SEEK_SET: sys.io.FileSeek.SeekBegin;
        }
        userdata.file.seek(offset, _w);
    }

    static function oclose(userdata:FileInfo):Void {
        trace('oclose');
        userdata.file.close();
        userdata = null;
    }

    static function otell(userdata:FileInfo):Int {
        trace('otell');
        return userdata.file.tell();
    }

    static function code(_code:OggCode) : String {
        return switch(_code){
            case OggCode.OV_EBADHEADER:'OV_EBADHEADER';
            case OggCode.OV_EBADLINK:'OV_EBADLINK';
            case OggCode.OV_EBADPACKET:'OV_EBADPACKET';
            case OggCode.OV_EFAULT:'OV_EFAULT';
            case OggCode.OV_EIMPL:'OV_EIMPL';
            case OggCode.OV_EINVAL:'OV_EINVAL';
            case OggCode.OV_ENOSEEK:'OV_ENOSEEK';
            case OggCode.OV_ENOTAUDIO:'OV_ENOTAUDIO';
            case OggCode.OV_ENOTVORBIS:'OV_ENOTVORBIS';
            case OggCode.OV_EOF:'OV_EOF';
            case OggCode.OV_EREAD:'OV_EREAD';
            case OggCode.OV_EVERSION:'OV_EVERSION';
            case OggCode.OV_FALSE:'OV_FALSE';
            case OggCode.OV_HOLE: 'OV_HOLE';
            case _:'$_code';
        }
    }

}