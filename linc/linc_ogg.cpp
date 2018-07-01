//hxcpp include should be first
#include <hxcpp.h>

#include "./linc_ogg.h"
#include "ogg/ogg.h"
#include "vorbis/vorbisfile.h"

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

        int ov_read(OggFile vf, Array<unsigned char> buffer, int byteOffset, int length, int bigendianp, int word, int sgned) {

            // printf("ov_read bufferlen:%lu length:%d bigendianp:%d word:%d sgned:%d\n", buffer->size(), length, bigendianp, word, sgned);

            //:todo: this value isn't returned yet but is only used for higher order sounds (multiple streams)
            int bitstream = -1;
            long _read = ov_read(vf.get_raw(), (char*)&buffer[0] + byteOffset, length, bigendianp, word, sgned, &bitstream);
            return (int)_read;

        } //ov_read

        int internal_open_callbacks(int cb_id, OggFile vf, OggBytesData initial, int ibytes) {

            ov_callbacks cb = ov_callbacks();

                cb.read_func = &ogg_read_func;
                cb.seek_func = &ogg_seek_func;
                cb.close_func = &ogg_close_func;
                cb.tell_func = &ogg_tell_func;

            int* int_id = new int;
            *int_id = cb_id;

            if(initial == null()) {
                return ov_open_callbacks(int_id, vf.get_raw(), NULL, 0, cb);
            } else {
                return ov_open_callbacks(int_id, vf.get_raw(), (char*)&initial[0], ibytes, cb);
            }

        } //ov_open_callbacks

        //internal

            static InternalReadFN read_fn = 0;
            static InternalSeekFN seek_fn = 0;
            static InternalCloseFN close_fn = 0;
            static InternalTellFN tell_fn = 0;
            static bool inited_callbacks = false;

            void init_callbacks(
                InternalReadFN _read_fn,
                InternalSeekFN _seek_fn,
                InternalCloseFN _close_fn,
                InternalTellFN _tell_fn
            ) {

                if(inited_callbacks) return;

                // printf("%s\n", "inited internal callbacks");
                // printf("has read:%d seek:%d close:%d tell:%d\n", _read_fn!=null(),_seek_fn!=null(),_close_fn!=null(),_tell_fn!=null());

                read_fn = _read_fn;
                seek_fn = _seek_fn;
                close_fn = _close_fn;
                tell_fn = _tell_fn;

                inited_callbacks = true;

            } //init_callbacks

            size_t ogg_read_func(void* ptr, size_t size, size_t nmemb, void* userdata) {

                int* cb_id = (int*)userdata;

                size_t total = size*nmemb;

                ::Array<unsigned char> arr = new Array_obj<unsigned char>(total,total);

                int res = read_fn(*cb_id, (int)size, (int)nmemb, arr);

                // printf("internal read cb:%d size:%lu nmemb:%lu total:%lu res:%d\n", *cb_id, size, nmemb, total, res);

                if(res != 0) {
                    memcpy(ptr, arr->GetBase(), total);
                }

                arr = null();

                return res;

            } //read_func

            int ogg_seek_func(void* userdata, ogg_int64_t offset, int whence) {

                int* cb_id = (int*)userdata;

                // printf("%s cb_id:%d offset:%lld whence:%d\n", "seek", *cb_id, offset, whence);

                return seek_fn(*cb_id, (int)offset, whence);

            } //seek_func

            int ogg_close_func(void* userdata) {

                int* cb_id = (int*)userdata;

                // printf("%s %d\n", "close", *cb_id);

                return close_fn(*cb_id);

            } //close_func

            long ogg_tell_func(void* userdata) {

                int* cb_id = (int*)userdata;

                // printf("%s %d\n", "tell", *cb_id);

                return tell_fn(*cb_id);

            } //tell_func

    } //ogg namespace

} // linc namespace