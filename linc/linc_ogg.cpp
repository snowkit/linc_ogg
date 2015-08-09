#include "./linc_ogg.h"

#include <hxcpp.h>

namespace linc {

    namespace ogg {

        ::cpp::Pointer<OggVorbis_File> newOggVorbisFile() {

            return cpp::Pointer<OggVorbis_File>( new OggVorbis_File() );

        } //newOggVorbisFile

        Dynamic ov_comment(::cpp::Pointer<OggVorbis_File> vf, int link) {

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

    } //ogg namespace

} // linc namespace