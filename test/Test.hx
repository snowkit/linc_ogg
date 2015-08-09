
import ogg.Ogg;

class Test {

    static function main() {

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

        trace('clear: ' + code(Ogg.ov_clear(file)));

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