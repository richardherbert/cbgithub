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

            for ( local.content in result ) {
                contents.append( populateContentFromAPI( local.content, arguments.encoding ) );
            }
        } else {
            var contents = populateContentFromAPI( result, arguments.encoding );
        }

        return contents;
    }

    function create(
        required string owner,
        required string repo,
        required string path,
        required string content,
        required string message,
        string branch = "master",
        string encoding = "utf-8"
    ) {
        arguments.endpoint = "/repos/#arguments.owner#/#arguments.repo#/contents/#arguments.path#";

        arguments.body = {
            'message': arguments.message,
            'content': toBase64( arguments.content ),
            'branch': arguments.branch
        };

        var response = APIRequest.put( argumentCollection = arguments );
        var result = deserializeJSON( response.filecontent );

        return populateContentFromAPI( result.content, arguments.encoding );
    }

    function update(
        required string owner,
        required string repo,
        required string path,
        required string content,
        required string message,
        required string sha,
        string branch = "master",
        string encoding = "utf-8"
    ) {
        arguments.endpoint = "/repos/#arguments.owner#/#arguments.repo#/contents/#arguments.path#";

        arguments.body = {
            'message': arguments.message,
            'content': toBase64( arguments.content ),
            'branch': arguments.branch,
            'sha': arguments.sha
        };

        var response = APIRequest.put( argumentCollection = arguments );
        var result = deserializeJSON( response.filecontent );

        return populateContentFromAPI( result.content, arguments.encoding );
    }

    function delete(
        required string owner,
        required string repo,
        required string path,
        required string message,
        required string sha,
        string branch = "master"
    ) {
        arguments.endpoint = "/repos/#arguments.owner#/#arguments.repo#/contents/#arguments.path#?message=#encodeForURL( arguments.message )#&sha=#arguments.sha#&branch=#arguments..branch#";

        var response = APIRequest.delete( argumentCollection = arguments );
        var result = deserializeJSON( response.filecontent );

        return populateContentFromAPI( {} );
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
