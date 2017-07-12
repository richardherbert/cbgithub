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
                expect( readme.getHtmlURL() ).toBe( "https://github.com/elpete/cbgithub/blob/master/README.md" );
                expect( readme.getPath() ).toBe( "README.md" );
                expect( readme.getDownloadURL() ).toBe( "https://raw.githubusercontent.com/elpete/cbgithub/master/README.md" );
                expect( readme.getEncoding() ).toBe( "base64" );

                expect( readme.getContent() ).toInclude( "GitHub" );
            } );

            it( "can read a file", function() {
                var files = ContentService.get( "elpete", "cbgithub", "ModuleConfig.cfc", "master" );

                expect( files.len() ).toBe( 1 );

                var file = files[ 1 ];

                expect( file ).toBeInstanceOf( "Content" );
                expect( file.getName() ).toBe( "ModuleConfig.cfc" );
                expect( file.getType() ).toBe( "file" );
                expect( file.getContent() ).toInclude( "function configure() {" );
            } );
        } );
    }

}
