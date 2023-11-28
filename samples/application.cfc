component {

	this.mappings["/root"]= GetDirectoryFromPath( GetCurrentTemplatePath() );

	public function onRequestStart(targetPage) {
		local.credentials = credentials();
		request.prc = {};
		request.prc.aws = new awscfml.aws(
		   argumentCollection = local.credentials
		);
	}

	private struct function credentials() {

		local.file = ExpandPath( "/root/credentials.json ");
		try{
			return deserializeJSON( FileRead( local.file ) );
		} 
		catch (any e) {
			local.extendedinfo = {"tagcontext"=e.tagcontext,"file"=local.file};
			throw(
				extendedinfo = SerializeJSON(local.extendedinfo),
				message      = "Unable to read credentials file:" & e.message, 
				detail       = "Please ensure you copy the sample credentials file and update with your details"
			);
		}		

	}

	function onError(e) {

		try {
			new cferrorHandler.errorHandler(e=arguments.e,debug=1);
		}
		catch (any e2) {
			throw(object=arguments.e);
		}
	}

}