component accessors="true" {

    property name="ContentService"
        inject="ContentService@cbgithub"
        getter="false"
        setter="false";

    property name="content" default="";
    property name="_links" default="";
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

    function init() {
        variables.base64Library = createObject( "java", "org.apache.commons.codec.binary.Base64" );
    }

    function getContent(
        string encoding = "UTF-8"
    ) {
// drop down into Java to decode the Base64 string due to a bug in Railo 4.2+ and Lucee 4+
// https://luceeserver.atlassian.net/browse/LDEV-555
        if( ( findNoCase( "lucee", server.coldfusion.productName )
            || findNoCase( "railo", server.coldfusion.productName ) )
        ) {
            var decodedContent = variables.base64Library.decodeBase64( variables.content );
        } else {
            var decodedContent = toBinary( variables.content );
        }

        return toString( decodedContent, arguments.encoding );
    }

    function getDownloadUrl() {
        return variables.download_url;
    }

    function getGitUrl() {
        return variables.git_url;
    }

    function getHtmlUrl() {
        return variables.html_url;
    }

    function getLinks() {
        return variables._links;
    }
}
