component extends="tests.resources.ModuleIntegrationSpec" appMapping="/app" {

    function beforeAll() {
        super.beforeAll();
        variables.ContentService = wirebox.getInstance( "ContentService@cbgithub" );
    }

    function run() {
        describe( "Contents...", function() {
            it( "can retrieve the README file", function() {
                var readme = ContentService.getReadMe( "elpete", "cbgithub", "master" );

                expect( readme ).toBeInstanceOf( "Content" );
                expect( readme.getName() ).toBe( "README.md" );
                expect( readme.getType() ).toBe( "file" );
                expect( readme.getContent() ).toInclude( "GitHub" );
            } );

            it( "can read a file", function() {
                var file = ContentService.get( "elpete", "cbgithub", "/ModuleConfig.cfc", "master" );

                expect( file ).toBeInstanceOf( "Content" );
                expect( file.getName() ).toBe( "ModuleConfig.cfc" );
                expect( file.getType() ).toBe( "file" );
                expect( file.getContent() ).toInclude( "function configure() {" );
            } );
        } );
    }

}
