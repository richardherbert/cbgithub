component extends="tests.resources.ModuleIntegrationSpec" appMapping="/app" {

    function beforeAll() {
        super.beforeAll();
        variables.ContentService = wirebox.getInstance( "ContentService@cbgithub" );
    }

    function run() {
        describe( "Contents...", function() {
            var owner = "elpete";
            var repo = "cbgithub";
            var ref = "master";

            it( title="can read the README file (text/plain)", body=function( data ) {
                var file = ContentService.getReadMe( data.owner, data.repo, data.ref );

                expect( file ).toBeInstanceOf( "testingModuleRoot.cbgithub.models.Content" );

                expect( file.getName() ).toBe( "README.md" );
                expect( file.getType() ).toBe( "file" );
                expect( file.getHtmlUrl() ).toBe( "https://github.com/#data.owner#/#data.repo#/blob/master/README.md" );
                expect( file.getPath() ).toBe( "README.md" );
                expect( file.getDownloadUrl() ).toBe( "https://raw.githubusercontent.com/#data.owner#/#data.repo#/master/README.md" );
                expect( file.getEncoding() ).toBe( "base64" );
                expect( file.getMimeType() ).toBe( "text/plain" );

                expect( file.getContent() ).toInclude( "GitHub" );
            }, data={ owner: owner, repo: repo, ref: ref } );


            var path = "models/Content.cfc";
            var filename = "Content.cfc";

            it( title="can read a file (text/plain)", body=function( data ) {
                var file = ContentService.get( data.owner, data.repo, data.path, data.ref );

                expect( file ).toBeInstanceOf( "testingModuleRoot.cbgithub.models.Content" );

                expect( file.getName() ).toBe( data.filename );
                expect( file.getType() ).toBe( "file" );
                expect( file.getHtmlUrl() ).toBe( "https://github.com/#data.owner#/#data.repo#/blob/master/#data.path#" );
                expect( file.getPath() ).toBe( "#data.path#" );
                expect( file.getDownloadUrl() ).toBe( "https://raw.githubusercontent.com/#data.owner#/#data.repo#/master/#data.path#" );
                expect( file.getEncoding() ).toBe( "base64" );
                expect( file.getMimeType() ).toBe( "text/plain" );

                expect( file.getContent() ).toInclude( 'property name="ContentService"' );
            }, data={ owner: owner, repo: repo, ref: ref, path: path, filename: filename } );


            var owner = "richardherbert";
            var ref = "develop";
            var path = "tests/resources/samples/sample_text_file.exe";

            it( title="can read a file (application/x-msdownload)", body=function( data ) {
                var file = ContentService.get( data.owner, data.repo, data.path, data.ref );

                expect( file.getName() ).toBe( "sample_text_file.exe" );
                expect( file.getType() ).toBe( "file" );
                expect( file.getHtmlUrl() ).toBe( "https://github.com/richardherbert/cbgithub/blob/develop/tests/resources/samples/sample_text_file.exe" );
                expect( file.getPath() ).toBe( "tests/resources/samples/sample_text_file.exe" );
                expect( file.getDownloadUrl() ).toBe( "https://raw.githubusercontent.com/richardherbert/cbgithub/develop/tests/resources/samples/sample_text_file.exe" );
                expect( file.getEncoding() ).toBe( "base64" );
                expect( file.getMimeType() ).toBe( "application/x-msdownload" );

            }, data={ owner: owner, repo: repo, ref: ref, path: path } );

            var path = "tests/resources/samples/sweep.png";

            it( title="can read a file (image/png)", body=function( data ) {
                var file = ContentService.get( data.owner, data.repo, data.path, data.ref );

                expect( file ).toBeInstanceOf( "testingModuleRoot.cbgithub.models.Content" );

                expect( file.getName() ).toBe( "sweep.png" );
                expect( file.getType() ).toBe( "file" );
                expect( file.getHtmlUrl() ).toBe( "https://github.com/richardherbert/cbgithub/blob/develop/tests/resources/samples/sweep.png" );
                expect( file.getPath() ).toBe( "tests/resources/samples/sweep.png" );
                expect( file.getDownloadUrl() ).toBe( "https://raw.githubusercontent.com/richardherbert/cbgithub/develop/tests/resources/samples/sweep.png" );
                expect( file.getEncoding() ).toBe( "base64" );
                expect( file.getMimeType() ).toBe( "image/png" );
            }, data={ owner: owner, repo: repo, ref: ref, path: path } );

            it( "can read a file (image/jpg)", function() {
                var file = ContentService.get( "richardherbert", "cbgithub", "tests/resources/samples/sooty3.jpg", "develop" );

                expect( file ).toBeInstanceOf( "testingModuleRoot.cbgithub.models.Content" );

                expect( file.getName() ).toBe( "sooty3.jpg" );
                expect( file.getType() ).toBe( "file" );
                expect( file.getHtmlUrl() ).toBe( "https://github.com/richardherbert/cbgithub/blob/develop/tests/resources/samples/sooty3.jpg" );
                expect( file.getPath() ).toBe( "tests/resources/samples/sooty3.jpg" );
                expect( file.getDownloadUrl() ).toBe( "https://raw.githubusercontent.com/richardherbert/cbgithub/develop/tests/resources/samples/sooty3.jpg" );
                expect( file.getEncoding() ).toBe( "base64" );
                expect( file.getMimeType() ).toBe( "image/jpeg" );
            } );

            it( "can read a file (application/pdf)", function() {
                var file = ContentService.get( "richardherbert", "cbgithub", "tests/resources/samples/pdf_open_parameters.pdf", "develop" );

                expect( file ).toBeInstanceOf( "testingModuleRoot.cbgithub.models.Content" );

                expect( file.getName() ).toBe( "pdf_open_parameters.pdf" );
                expect( file.getType() ).toBe( "file" );
                expect( file.getHtmlUrl() ).toBe( "https://github.com/richardherbert/cbgithub/blob/develop/tests/resources/samples/pdf_open_parameters.pdf" );
                expect( file.getPath() ).toBe( "tests/resources/samples/pdf_open_parameters.pdf" );
                expect( file.getDownloadUrl() ).toBe( "https://raw.githubusercontent.com/richardherbert/cbgithub/develop/tests/resources/samples/pdf_open_parameters.pdf" );
                expect( file.getEncoding() ).toBe( "base64" );
                expect( file.getMimeType() ).toBe( "application/pdf" );
            } );

            it( "can read a file (application/x-tika-ooxml)", function() {
               var file = ContentService.get( "richardherbert", "cbgithub", "tests/resources/samples/sample_word_file.docx", "develop" );

                expect( file ).toBeInstanceOf( "testingModuleRoot.cbgithub.models.Content" );

                expect( file.getName() ).toBe( "sample_word_file.docx" );
                expect( file.getType() ).toBe( "file" );
                expect( file.getHtmlUrl() ).toBe( "https://github.com/richardherbert/cbgithub/blob/develop/tests/resources/samples/sample_word_file.docx" );
                expect( file.getPath() ).toBe( "tests/resources/samples/sample_word_file.docx" );
                expect( file.getDownloadUrl() ).toBe( "https://raw.githubusercontent.com/richardherbert/cbgithub/develop/tests/resources/samples/sample_word_file.docx" );
                expect( file.getEncoding() ).toBe( "base64" );
                expect( file.getMimeType() ).toBe( "application/x-tika-ooxml" );
            } );

            it( "can read a directory", function() {
                var files = ContentService.get( "elpete", "cbgithub", "models", "master" );

                expect( files ).toBeArray();

                files.each( function( file ) {
                    expect( file ).toBeInstanceOf( "testingModuleRoot.cbgithub.models.Content" );
                } );
            } );
        } );
    }

}
