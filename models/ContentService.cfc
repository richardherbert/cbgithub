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
                contents.append( populateContentFromAPI( content, arguments.encoding ) );
            }
        } else {
            contents.append( populateContentFromAPI( result, arguments.encoding ) );
        }

        return contents;
    }

    private function populateContentFromAPI(
        required struct result,
        string encoding = "utf-8",
        content = wirebox.getInstance( "Content@cbgithub" )
    ) {
        param arguments.result.content = "";
        param arguments.result.encoding = "";

        if( result.type == "file" && result.content != "" && findNoCase( 'lucee', server.coldfusion.productName ) ) {
            result.content = correctBinaryForLucee( result.content );
        }

        return populator.populateFromStruct(
            target = content,
            memento = {
                "content" = toString( binaryDecode( result.content, result.encoding ), arguments.encoding ),
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
    }

    private function correctBinaryForLucee(
        required string string
    ) {
        var content = trim( arguments.string );
        var lastChar = mid( content, content.len()-1, 1 );

        if( lastChar == '=' ) {
            return mid( content, 1, content.len()-1 );
        }

        return content;
    }

}
