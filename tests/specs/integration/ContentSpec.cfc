component extends="tests.resources.ModuleIntegrationSpec" appMapping="/app" {

    function beforeAll() {
        super.beforeAll();
        variables.ContentService = wirebox.getInstance( "ContentService@cbgithub" );
    }

    function run() {
        describe( "Contents...", function() {
            it( "can retrieve the README file", function() {
                var readme = ContentService.getReadMe( "elpete", "cbgithub", "master" );

                expect( readme ).toBeInstanceOf( "testingModuleRoot.cbgithub.models.Content" );

                expect( readme.getName() ).toBe( "README.md" );
                expect( readme.getType() ).toBe( "file" );
                expect( readme.getHtmlUrl() ).toBe( "https://github.com/elpete/cbgithub/blob/master/README.md" );
                expect( readme.getPath() ).toBe( "README.md" );
                expect( readme.getDownloadUrl() ).toBe( "https://raw.githubusercontent.com/elpete/cbgithub/master/README.md" );
                expect( readme.getEncoding() ).toBe( "base64" );

                expect( readme.getContent() ).toInclude( "GitHub" );
            } );

            it( "can read a file", function() {
                var file = ContentService.get( "elpete", "cbgithub", "ModuleConfig.cfc", "master" );

                expect( file ).toBeInstanceOf( "testingModuleRoot.cbgithub.models.Content" );

                expect( file.getName() ).toBe( "ModuleConfig.cfc" );
                expect( file.getType() ).toBe( "file" );
                expect( file.getHtmlUrl() ).toBe( "https://github.com/elpete/cbgithub/blob/master/ModuleConfig.cfc" );
                expect( file.getPath() ).toBe( "ModuleConfig.cfc" );
                expect( file.getDownloadUrl() ).toBe( "https://raw.githubusercontent.com/elpete/cbgithub/master/ModuleConfig.cfc" );
                expect( file.getEncoding() ).toBe( "base64" );


                expect( file.getContent() ).toInclude( "function configure() {" );
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
