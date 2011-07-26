<cfoutput>
<!--============================Sidebar============================-->
<div class="sidebar">
	<!--- Search Box --->
	<div class="small_box">
		<div class="header">
			<img src="#prc.bbroot#/includes/images/search.png" alt="info" width="24" height="24" />Author Search
		</div>
		<div class="body">
			<!--- Search Form --->
			#html.startForm(name="authorSearchForm",action=rc.xehAuthorSearch)#
				#html.textField(label="Search:",name="searchAuthor",class="textfield",size="16",title="Search authors by name, username or email",value=event.getValue("searchAuthor",""))#
				<input type="submit" class="buttonred" value="Search" />
				<button class="button" onclick="return to('#event.buildLink(rc.xehAuthors)#')">Clear</button>				
			#html.endForm()#			
		</div>
	</div>		
</div>
<!--End sidebar-->	
<!--============================Main Column============================-->
<div class="main_column">
	<div class="box">
		<!--- Body Header --->
		<div class="header">
			<img src="#prc.bbroot#/includes/images/user-admin.png" alt="sofa" width="30" height="30" title="I am a geek and I love it!"/>
			Author Management
		</div>
		<!--- Body --->
		<div class="body">
			<!--- MessageBox --->
			#getPlugin("MessageBox").renderit()#
			
			<!--- AuthorForm --->
			#html.startForm(name="authorForm",action=rc.xehAuthorRemove)#
			<input type="hidden" name="authorID" id="authorID" value="" />
			
			<div class="contentBar">
				<!--- Create Butons --->
				<div class="buttonBar">
					<button class="button2" onclick="return to('#event.buildLink(rc.xehAuthorEditor)#')" title="Create new author">Create Author</button>
				</div>
				
				<!--- Filter Bar --->
				<div class="filterBar">
					<div>
						#html.label(field="authorFilter",content="Quick Filter:",class="inline")#
						#html.textField(name="authorFilter",size="30",class="textfield")#
					</div>
				</div>
			</div>
			
			<!--- Paging --->
			#rc.pagingPlugin.renderit(rc.authorCount,rc.pagingLink)#
		
			<!--- authors --->
			<table name="authors" id="authors" class="tablesorter" width="98%">
				<thead>
					<tr>
						<th>Name</th>
						<th>Email</th>
						<th>Username</th>
						<th>Last Login</th>
						<th width="75">Active</th>
						<th width="125" class="center {sorter: false}">Actions</th>
					</tr>
				</thead>
				
				<tbody>
					<cfloop array="#rc.authors#" index="author">
					<tr<cfif prc.oAuthor.getAuthorID() eq author.getAuthorID()> class="selected"</cfif>>
						<td>
							#getMyPlugin(plugin="Avatar",module="blogbox").renderAvatar(email=author.getEmail(),size="30")#
							<a href="#event.buildLink(rc.xehAuthorEditor)#/authorID/#author.getAuthorID()#" title="Edit #author.getName()#">#author.getName()#</a>
							<cfif prc.oAuthor.getAuthorID() eq author.getAuthorID()>
								<img src="#prc.bbRoot#/includes/images/asterisk_orange.png" alt="you" title="You dude!" />
							</cfif>
						</td>
						<td>#author.getEmail()#</td>
						<td>#author.getUsername()#</td>
						<td>#author.getDisplayLastLogin()#</td>
						<td class="center">
							<cfif author.getIsActive()>
								<img src="#prc.bbRoot#/includes/images/button_ok.png" alt="ok" title="User Active" />
							<cfelse>
								<img src="#prc.bbRoot#/includes/images/button_cancel.png" alt="off" title="User Deactivated" />
							</cfif>
						</td>
						<td class="center">
							<!--- Edit Command --->
							<a href="#event.buildLink(rc.xehAuthorEditor)#/authorID/#author.getAuthorID()#" title="Edit #author.getName()#"><img src="#prc.bbroot#/includes/images/edit.png" alt="edit" /></a>
							<!--- Delete Command --->
							<cfif prc.oAuthor.getAuthorID() neq author.getAuthorID()>
							<a title="Delete Author" href="javascript:removeAuthor('#author.getAuthorID()#')" class="confirmIt" data-title="Delete Author?"><img id="delete_#author.getAuthorID()#" src="#prc.bbroot#/includes/images/delete.png" border="0" alt="delete"/></a>
							</cfif>
						</td>
					</tr>
					</cfloop>
				</tbody>
			</table>
			
			<!--- Paging --->
			#rc.pagingPlugin.renderit(rc.authorCount,rc.pagingLink)#
		
			#html.endForm()#
		
		</div>	<!--- body --->
	</div> <!--- main box --->
</div> <!--- main column --->

<script type="text/javascript">
$(document).ready(function() {
	$("##authors").tablesorter();
	$("##authorFilter").keyup(function(){
		$.uiTableFilter( $("##authors"), this.value );
	})
});
function removeAuthor(authorID){
	$("##authorID").val( authorID );
	$("##authorForm").submit();
}
</script>
</cfoutput>