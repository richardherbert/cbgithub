component extends="tests.resources.ModuleIntegrationSpec" appMapping="/app" {

    function beforeAll() {
        super.beforeAll();
        variables.ContentService = wirebox.getInstance( "ContentService@cbgithub" );
    }

    void function commonCreateExpectations( required file, required string owner, required string repo, required string path, required string ref, required string name, required string type ) {
        commonExpectations( arguments.file, arguments.owner, arguments.repo, arguments.path, arguments.ref, arguments.name, arguments.type );
    }

    void function commonReadExpectations( required file, required string owner, required string repo, required string path, required string ref, required string name, required string type, required string mimeType ) {
        commonExpectations( arguments.file, arguments.owner, arguments.repo, arguments.path, arguments.ref, arguments.name, arguments.type );

        expect( arguments.file.getEncoding() ).toBe( "base64" );
        expect( arguments.file.getMimeType() ).toBe( arguments.mimeType );
    }

    void function commonExpectations( required file, required string owner, required string repo, required string path, required string ref, required string name, required string type ) {
        var htmlUrl = "https://github.com/#arguments.owner#/#arguments.repo#/blob/#arguments.ref#/#arguments.path#";
        var downloadUrl = "https://raw.githubusercontent.com/#arguments.owner#/#arguments.repo#/#arguments.ref#/#arguments.path#";

        expect( arguments.file ).toBeInstanceOf( "testingModuleRoot.cbgithub.models.Content" );

        expect( arguments.file.getName() ).toBe( arguments.name );
        expect( arguments.file.getType() ).toBe( arguments.type );
        expect( arguments.file.getHtmlUrl() ).toBe( htmlUrl );
        expect( arguments.file.getPath() ).toBe( arguments.path );
        expect( arguments.file.getDownloadUrl() ).toBe( downloadUrl );
    }

    function run() {
        describe( "Contents - Create, Update and Delete", function() {
            var owner  = "example";
            var repo   = "example.com";
            var branch = "master";

            var createFile = "myCreateFile.txt";
            var updateFile = "myUpdateFile.txt";
            var deleteFile = "myDeleteFile.txt";

            it( title="can create a file (text/plain)", body=function( data ) {
                var file = ContentService.create( owner=data.owner, repo=data.repo, path=data.path, content=data.content, message=data.message, branch=data.branch );

                var filename = listLast( data.path, "/" );

                commonCreateExpectations( file, data.owner, data.repo, data.path, data.branch, filename, "file" );

                var createdFile = ContentService.read( data.owner, data.repo, data.path, data.branch );

                expect( createdFile.getContent() ).toInclude( data.content );
            }, data={ owner: owner, repo: repo, branch: branch, path: createFile, content: "File created by cbgithub - #dateTimeFormat( now(), 'yyyy-mm-dd HH:nn:ss', 'UTC' )#", message: "File created by cbgithub" } );

            it( title="can update a file (text/plain)", body=function( data ) {
                var existingFile = ContentService.read( data.owner, data.repo, data.path, data.branch );

                var file = ContentService.update( owner=data.owner, repo=data.repo, path=data.path, content=data.content, message=data.message, sha=existingFile.getSha(), branch=data.branch );

                var filename = listLast( data.path, "/" );

                commonCreateExpectations( file, data.owner, data.repo, data.path, data.branch, filename, "file", "text/plain" );

                var updatedFile = ContentService.read( data.owner, data.repo, data.path, data.branch );

                expect( updatedFile.getContent() ).toInclude( data.content );
            }, data={ owner: owner, repo: repo, branch: branch, path: updateFile, content: "File updated by cbgithub - #dateTimeFormat( now(), 'yyyy-mm-dd HH:nn:ss', 'UTC' )#", message: "File updated by cbgithub" } );

            it( title="can delete a file (text/plain)", body=function( data ) {
                var createdFile = ContentService.create( owner=data.owner, repo=data.repo, path=data.path, content=data.content, message="File created by cbgithub", branch=data.branch );

                var filename = listLast( data.path, "/" );

                expect( createdFile.getName() ).toBe( filename );

                var file = ContentService.delete( owner=data.owner, repo=data.repo, path=data.path, message=data.message, sha=createdFile.getSha(), branch=data.branch );

                try {
                    ContentService.read( data.owner, data.repo, data.path, data.branch );
                } catch ( any exception ) {
                    expect( deserializeJSON( exception.message ).message ).toBe( "Not Found" );
                }
            }, data={ owner: owner, repo: repo, branch: branch, path: deleteFile, content: "File deleted by cbgithub - #dateTimeFormat( now(), 'yyyy-mm-dd HH:nn:ss', 'UTC' )#", message: "File deleted by cbgithub" } );
        } );

        xdescribe( "Contents - Read", function() {
            var owner = "coldbox-modules";
            var repo  = "cbgithub";
            var ref   = "master";

            it( title="can read the README file (text/plain)", body=function( data ) {
                var file = ContentService.getReadMe( data.owner, data.repo, data.ref );
                var filename = listLast( data.path, "/" );

                commonReadExpectations( file, data.owner, data.repo, data.path, data.ref, filename, "file", "text/plain" );

                expect( file.getContent() ).toInclude( "GitHub" );
            }, data={ owner: owner, repo: repo, ref: ref, path: "README.md" } );

            it( title="can read a file (text/plain)", body=function( data ) {
                var file = ContentService.read( data.owner, data.repo, data.path, data.ref );
                var filename = listLast( data.path, "/" );

                commonReadExpectations( file, data.owner, data.repo, data.path, data.ref, filename, "file", "text/plain" );

                expect( file.getContent() ).toInclude( 'property name="ContentService"' );
            }, data={ owner: owner, repo: repo, ref: ref, path: "models/Content.cfc" } );

            it( title="can read a file (application/x-msdownload)", body=function( data ) {
                var file = ContentService.read( data.owner, data.repo, data.path, data.ref );
                var filename = listLast( data.path, "/" );

                commonReadExpectations( file, data.owner, data.repo, data.path, data.ref, filename, "file", "application/x-msdownload" );
            }, data={ owner: owner, repo: repo, ref: ref, path: "tests/resources/samples/sample_text_file.exe" } );

            it( title="can read a file (image/png)", body=function( data ) {
                var file = ContentService.read( data.owner, data.repo, data.path, data.ref );
                var filename = listLast( data.path, "/" );

                commonReadExpectations( file, data.owner, data.repo, data.path, data.ref, filename, "file", "image/png" );
            }, data={ owner: owner, repo: repo, ref: ref, path: "tests/resources/samples/sweep.png" } );

            it( title="can read a file (image/jpg)", body=function( data ) {
                var file = ContentService.read( data.owner, data.repo, data.path, data.ref );
                var filename = listLast( data.path, "/" );

                commonReadExpectations( file, data.owner, data.repo, data.path, data.ref, filename, "file", "image/jpeg" );
            }, data={ owner: owner, repo: repo, ref: ref, path: "tests/resources/samples/sooty3.jpg" } );

            it( title="can read a file (application/pdf)", body=function( data ) {
                var file = ContentService.read( data.owner, data.repo, data.path, data.ref );
                var filename = listLast( data.path, "/" );

                commonReadExpectations( file, data.owner, data.repo, data.path, data.ref, filename, "file", "application/pdf" );
            }, data={ owner: owner, repo: repo, ref: ref, path: "tests/resources/samples/pdf_open_parameters.pdf" } );

            it( title="can read a file (application/x-tika-ooxml)", body=function( data ) {
                var file = ContentService.read( data.owner, data.repo, data.path, data.ref );
                var filename = listLast( data.path, "/" );

                commonReadExpectations( file, data.owner, data.repo, data.path, data.ref, filename, "file", "application/x-tika-ooxml" );
            }, data={ owner: owner, repo: repo, ref: ref, path: "tests/resources/samples/sample_word_file.docx" } );

            it( title="can read a directory", body=function( data ) {
                var files = ContentService.read( data.owner, data.repo, data.path, data.ref );

                expect( files ).toBeArray();

                files.each( function( file ) {
                    expect( file ).toBeInstanceOf( "testingModuleRoot.cbgithub.models.Content" );
                } );
            }, data={ owner: owner, repo: repo, ref: ref, path: "models" } );
        } );
    }

}
