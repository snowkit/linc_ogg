#include "./linc_ogg.h"

#include <hxcpp.h>

namespace linc {

    namespace ogg {

        OggFile newOggVorbisFile() {

            return OggFile( new OggVorbis_File() );

        } //newOggVorbisFile

        Dynamic ov_comment(OggFile vf, int link) {

            vorbis_comment* src_comment = ov_comment(vf.get_raw(), -1);

            if(src_comment) {

                hx::Anon result = hx::Anon_obj::Create();
                Array< ::String > comments = Array_obj< ::String >::__new();

                    result->Add(HX_CSTRING("vendor"), ::String(src_comment->vendor));
                    result->Add(HX_CSTRING("comments"), comments);

                    for(int i = 0; i < src_comment->comments; i++) {
                        comments.Add(::String(src_comment->user_comments[i]));
                    }

                return result;

            } //src_comment

            return null();

        } //ov_comment

        int ov_read(OggFile vf, Array<unsigned char> buffer, int length, int bigendianp, int word, int sgned) {

            //:todo: this value isn't returned yet but is only used for higher order sounds (multiple streams)
            int bitstream = -1;
            long _read = ov_read(vf.get_raw(), (char*)&buffer[0], length, bigendianp, word, sgned, &bitstream);
            return (int)_read;

        } //ov_read

    } //ogg namespace

} // linc namespace