component extends="tests.resources.ModuleIntegrationSpec" appMapping="/app" {

    function beforeAll() {
        super.beforeAll();
        variables.ContentService = wirebox.getInstance( "ContentService@cbgithub" );
    }

    function run() {
        describe( "Contents...", function() {
            xit( "can read the README file", function() {
                var file = ContentService.getReadMe( "elpete", "cbgithub", "master" );

                expect( file ).toBeInstanceOf( "testingModuleRoot.cbgithub.models.Content" );

                expect( file.getName() ).toBe( "README.md" );
                expect( file.getType() ).toBe( "file" );
                expect( file.getHtmlUrl() ).toBe( "https://github.com/elpete/cbgithub/blob/master/README.md" );
                expect( file.getPath() ).toBe( "README.md" );
                expect( file.getDownloadUrl() ).toBe( "https://raw.githubusercontent.com/elpete/cbgithub/master/README.md" );
                expect( file.getEncoding() ).toBe( "base64" );
                expect( file.getMimeType() ).toBe( "text/plain" );

                // expect( readme.isContentImage() ).toBeFalse();
debug(file.getMimeType());
debug(file);

                expect( file.getContent() ).toInclude( "GitHub" );
            } );

            xit( "can read a file", function() {
                var file = ContentService.get( "elpete", "cbgithub", "ModuleConfig.cfc", "master" );

                expect( file ).toBeInstanceOf( "testingModuleRoot.cbgithub.models.Content" );

                expect( file.getName() ).toBe( "ModuleConfig.cfc" );
                expect( file.getType() ).toBe( "file" );
                expect( file.getHtmlUrl() ).toBe( "https://github.com/elpete/cbgithub/blob/master/ModuleConfig.cfc" );
                expect( file.getPath() ).toBe( "ModuleConfig.cfc" );
                expect( file.getDownloadUrl() ).toBe( "https://raw.githubusercontent.com/elpete/cbgithub/master/ModuleConfig.cfc" );
                expect( file.getEncoding() ).toBe( "base64" );
                expect( file.getMimeType() ).toBe( "text/plain" );

                // expect( file.isContentImage() ).toBeFalse();


debug(file.getMimeType());
debug(file);



                expect( file.getContent() ).toInclude( "function configure() {" );
            } );




            it( "can read a file (application/x-msdownload)", function() {
                var file = ContentService.get( "richardherbert", "cbgithub", "tests/resources/samples/sample_text_file.exe", "develop" );

debug(file.getMimeType());
debug(file);

                expect( file ).toBeInstanceOf( "testingModuleRoot.cbgithub.models.Content" );

                expect( file.getName() ).toBe( "sample_text_file.exe" );
                expect( file.getType() ).toBe( "file" );
                expect( file.getHtmlUrl() ).toBe( "https://github.com/richardherbert/cbgithub/blob/develop/tests/resources/samples/sample_text_file.exe" );
                expect( file.getPath() ).toBe( "tests/resources/samples/sample_text_file.exe" );
                expect( file.getDownloadUrl() ).toBe( "https://raw.githubusercontent.com/richardherbert/cbgithub/develop/tests/resources/samples/sample_text_file.exe" );
                expect( file.getEncoding() ).toBe( "base64" );
                expect( file.getMimeType() ).toBe( "application/x-msdownload" );
            } );

            it( "can read a file (image/png)", function() {
                var file = ContentService.get( "richardherbert", "cbgithub", "tests/resources/samples/sweep.png", "develop" );

debug(file.getMimeType());
debug(file);

                expect( file ).toBeInstanceOf( "testingModuleRoot.cbgithub.models.Content" );

                expect( file.getName() ).toBe( "sweep.png" );
                expect( file.getType() ).toBe( "file" );
                expect( file.getHtmlUrl() ).toBe( "https://github.com/richardherbert/cbgithub/blob/develop/tests/resources/samples/sweep.png" );
                expect( file.getPath() ).toBe( "tests/resources/samples/sweep.png" );
                expect( file.getDownloadUrl() ).toBe( "https://raw.githubusercontent.com/richardherbert/cbgithub/develop/tests/resources/samples/sweep.png" );
                expect( file.getEncoding() ).toBe( "base64" );
                expect( file.getMimeType() ).toBe( "image/png" );
            } );

            it( "can read a file (image/jpg)", function() {
                var file = ContentService.get( "richardherbert", "cbgithub", "tests/resources/samples/sooty3.jpg", "develop" );

debug(file.getMimeType());
debug(file);

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

debug(file.getMimeType());
debug(file);

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

debug(file.getMimeType());
debug(file);

                expect( file ).toBeInstanceOf( "testingModuleRoot.cbgithub.models.Content" );

                expect( file.getName() ).toBe( "sample_word_file.docx" );
                expect( file.getType() ).toBe( "file" );
                expect( file.getHtmlUrl() ).toBe( "https://github.com/richardherbert/cbgithub/blob/develop/tests/resources/samples/sample_word_file.docx" );
                expect( file.getPath() ).toBe( "tests/resources/samples/sample_word_file.docx" );
                expect( file.getDownloadUrl() ).toBe( "https://raw.githubusercontent.com/richardherbert/cbgithub/develop/tests/resources/samples/sample_word_file.docx" );
                expect( file.getEncoding() ).toBe( "base64" );
                expect( file.getMimeType() ).toBe( "application/x-tika-ooxml" );
            } );

            xit( "can read a directory", function() {
                var files = ContentService.get( "elpete", "cbgithub", "models", "master" );
// debug(files.getMimeType());
// debug(files);

                expect( files ).toBeArray();

                files.each( function( file ) {
                    expect( file ).toBeInstanceOf( "testingModuleRoot.cbgithub.models.Content" );
                } );
            } );
        } );
    }

}
