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

        return populateContentFromAPI( result );
    }

    function get(
        required string owner,
        required string repo,
        required string path,
        string ref = "master",
        string encoding = "utf-8"
    ) {
        arguments.endpoint = "/repos/#arguments.owner#/#repo#/contents/#path#?ref=#arguments.ref#";

        var response = APIRequest.get( argumentCollection = arguments );
        var result = deserializeJSON( response.filecontent );

        if ( isArray( result ) ) {
            var contents = [];

            for ( var content in result ) {
                contents.append( populateContentFromAPI( content, arguments.encoding ) );
            }
        } else {
            var contents = populateContentFromAPI( result, arguments.encoding );
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

        return populator.populateFromStruct(
            target = content,
            memento = {
                "content" = arguments.result.content,
                "_links" = arguments.result._links,
                "html_url" = arguments.result.html_url,
                "sha" = arguments.result.sha,
                "path" = arguments.result.path,
                "url" = arguments.result.url,
                "size" = arguments.result.size,
                "name" = arguments.result.name,
                "type" = arguments.result.type,
                "git_url" = arguments.result.git_url,
                "download_url" = arguments.result.download_url,
                "encoding" = arguments.result.encoding
            },
            ignoreEmpty = true
        );
    }

}
