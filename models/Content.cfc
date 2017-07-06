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

    function init() {
    }

}
