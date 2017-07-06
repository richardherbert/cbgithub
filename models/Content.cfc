component accessors="true" {

    property name="ContentService"
        inject="ContentService@cbgithub"
        getter="false"
        setter="false";

    property name="content" default="";
    property name="_links" default=structNew();
    property name="html_url" default="";
    property name="sha" default="";
    property name="path" default="";
    property name="url" default="";
    property name="size" default="";
    property name="name" default="";
    property name="type" default="";
    property name="git_url" default="";
    property name="download_url" default="";
    property name="encoding" default="";

    function init() {}

    function getContent(
        string encoding = "utf-8"
    ) {
        if( findNoCase( 'lucee', server.coldfusion.productName ) && variables.getType() == "file" && variables.content != "" ) {
            variables.content = stripTrailingEqualsForLucee( variables.content );
        }

        return toString( binaryDecode( variables.content, variables.getEncoding() ), arguments.encoding );
    }

////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

    private function stripTrailingEqualsForLucee(
        required string content
    ) {
        var string = trim( arguments.content );

        while( mid( string, string.len(), 1 ) == "=" ) {
            string = mid( string, 1, string.len()-1 );
        }

        return string;
    }

}
