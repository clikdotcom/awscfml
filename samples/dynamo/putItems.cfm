<cfscript>
table = "articles_test2";


article = {
	"sites_id" = 1,
	"articles_id" = 1,
	"section_id" = 1,
	"headline" = "Lorem ipsum dolor sit amet",
	"strapline" = "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam",
	"body" = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
	"pubdate" = now()
};


counter = 1;
stopwatch variable="timer" {
	for (sites_id=1; sites_id lte 3; sites_id++) {

		article.sites_id = sites_id
		for (i=1; i lte 20; i++) {
			article.articles_id = i;
			article.section_id = i % 4;
			 request.prc.aws.dynamodb.putitem(TableName=table,item=article);
			 counter++;
		}

	}
}


writeOutput("#counter# done in #timer#ms (#round(timer/counter)#ms/item)");


</cfscript>