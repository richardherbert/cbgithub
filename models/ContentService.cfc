component {

    property name="wirebox" inject="wirebox";
    property name="populator" inject="wirebox:populator";
    property name="APIRequest" inject="APIRequest@cbgithub";

    function getReadme(
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

    function read(
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
        content
    ) {
        param arguments.result.content = "";
        param arguments.result.encoding = "";
        param arguments.result.submodule_git_url = "";

        if ( isNull( arguments.content ) ) {
            arguments.content = wirebox.getInstance( "Content@cbgithub" );
        }
        return populator.populateFromStruct(
            target = content,
            memento = arguments.result,
            ignoreEmpty = true
        );
    }

}
