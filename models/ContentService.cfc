component {

    property name="wirebox" inject="wirebox";
    property name="populator" inject="wirebox:populator";
    property name="APIRequest" inject="APIRequest@cbgithub";

    function getReadMe(
        required string owner,
        required string repo,
        string ref = "master",
        string encoding = "utf-8"
    ) {
        arguments.endpoint = "/repos/#arguments.owner#/#repo#/readme?ref=#arguments.ref#";

        var response = APIRequest.get( argumentCollection = arguments );
        var result = deserializeJSON( response.filecontent );

        return populateContentFromAPI( result )

// writedump( var='#result#', label='result', expand=0, abort=1, format='classic' );
        // return toString( toBinary( result.content ), arguments.encoding );
    }

    function get(
        required string owner,
        required string repo,
        required string path,
        string ref = "master",
        string encoding = "utf-8"
    ) {
        arguments.endpoint = "/repos/#arguments.owner#/#repo#/contents/#path#?ref=#arguments.ref#";

        var contents = [];

        var response = APIRequest.get( argumentCollection = arguments );
        var result = deserializeJSON( response.filecontent );

        if ( isArray( result ) ) {
            for ( var content in result ) {
                contents.append( populateContentFromAPI( content ) );
            }
        } else {
            contents.append( populateContentFromAPI( result ) );
        }

        return contents;
    }

    private function populateContentFromAPI(
        required struct result,
        content = wirebox.getInstance( "Content@cbgithub" )
    ) {
        param result.content = "";
        param result.encoding = "";


try {
        return populator.populateFromStruct(
            target = content,
            memento = {
                // "content" = toString( toBinary( result.content ), arguments.encoding ),
                "content" = toString( toBinary( trim( result.content ) ) ),
                "_links" = result._links,
                "html_url" = result.html_url,
                "sha" = result.sha,
                "path" = result.path,
                "url" = result.url,
                "size" = result.size,
                "name" = result.name,
                "type" = result.type,
                "git_url" = result.git_url,
                "download_url" = result.download_url,
                "encoding" = result.encoding
            },
            ignoreEmpty = true
        );
} catch( any exception ) {

var bin = trim( result.content );
var lastChar = mid( bin, bin.len()-1, 1 );

if( lastChar == '=' ) {
   var stripLastChar = mid( bin, 1, bin.len()-1 );
writedump( var='#result.content#<<', label='result.content', expand=0, abort=0, format='classic' );
writedump( var='#stripLastChar#<<', label='stripLastChar', expand=0, abort=0, format='classic' );

writedump( var='#isBinary(toBinary(result.content))#', label='isBinary(toBinary(result.content))', expand=0, abort=0, format='classic' );
writedump( var='#isBinary(toBinary(stripLastChar))#', label='isBinary(toBinary(stripLastChar))', expand=0, abort=0, format='classic' );

writedump( var='#toString(toBinary(stripLastChar))#', label='', expand=0, abort=1, format='classic' );

    writedump( var='yep', label='', expand=0, abort=1, format='classic' );
}
writedump( var='#result.content.len()# #bin.len()#', label='result.content.len()', expand=0, abort=1, format='classic' );


writedump( var='#isBinary(result.content)#', label='isBinary(result.content)', expand=0, abort=1, format='classic' );

writedump( var='#result#', label='result', expand=0, abort=0, format='classic' );


writedump( var='#binaryDecode(result.content,'base64')#', label='result.content', expand=1, abort=1, format='classic' );

writedump( var='#toString( toBinary( trim( "77u/Y29tcG9uZW50IHsKCXB1YmxpYyBTZWxlbml1bVdlYkRyaXZlciBmdW5j dGlvbiBpbml0KCByZXF1cmllZCBzdHJpbmcgZHJpdmVyVHlwZSwgcmVxdWly ZWQgc3RyaW5nIHdlYmRyaXZlciApIHsKCQlzZXREcml2ZXJCeVR5cGUoIGRy aXZlclR5cGUsIHdlYmRyaXZlciApOwoKCQlyZXR1cm4gdGhpczsKCX0KCglw dWJsaWMgY2ZzZWxlbml1bS5kcml2ZXJzLldlYkRyaXZlciBmdW5jdGlvbiBn ZXREcml2ZXIoKSB7CgkJcmV0dXJuIHZhcmlhYmxlcy5kcml2ZXI7Cgl9CgoJ cHVibGljIHZvaWQgZnVuY3Rpb24gc2V0RHJpdmVyQnlUeXBlKCByZXF1aXJl ZCBzdHJpbmcgZHJpdmVyVHlwZSwgcmVxdWlyZWQgc3RyaW5nIHdlYmRyaXZl ciApIHsKCQlzd2l0Y2goIGRyaXZlclR5cGUgKSB7CgkJCWNhc2UgJ2ZpcmVm b3gnOgoJCQkJdmFyaWFibGVzLmRyaXZlciA9IG5ldyBjZnNlbGVuaXVtLmRy aXZlcnMuRmlyZUZveERyaXZlciggd2ViZHJpdmVyICk7CgkJCWJyZWFrOwoK CQkJZGVmYXVsdDoKCQkJCXZhcmlhYmxlcy5kcml2ZXIgPSBuZXcgY2ZzZWxl bml1bS5kcml2ZXJzLldlYkRyaXZlciggd2ViZHJpdmVyICk7CgkJCWJyZWFr OwoJCX0KCgkJcmV0dXJuOwoJfQp9Cg=" ) ) )#', label='', expand=0, abort=1, format='classic' );

    writedump( var='#exception#', label='try/catch', expand=1, abort=1, format='html' );
}
    }

}
