% include header username = username, redirectUrl='home', currentUrl='simpleMessage'

  <div><h2><em>Hello, developers!</em><h2> </div>
  
  <p>
	  This is version 2 of Lauren's Lovely Landscapes.  Version 1 is a static sample 
	  app that demonstrates how easy it is to deploy an app using IBM Bluemix. Version 2 
	  expands Lauren's Lovely Landscapes to dynamically display prints as well as allow users 
	  to register, sign in, sign out, and buy prints. 
  </p>
  
  <p>
  	Version 1 is hosted at <a href="http://laurenslovelylandscapes.mybluemix.net">
  	http://laurenslovelylandscapes.mybluemix.net</a>.  The tutorial associated with 
  	Version 1 is posted at <a href="https://www.ibm.com/developerworks/cloud/library/cl-intro1-app">
  	https://www.ibm.com/developerworks/cloud/library/cl-intro1-app</a>.
  </p>
  
  <p>
  	The rest of the information on this page pertains to Version 2.
  </p>
  
  <h3>No prints listed on the home page?</h3>
  <a href="insertSampleData">Insert the sample data</a>.
  
  <h3>Want your own copy of the app?</h3>
  I thought you might.  Get a copy of my code <a href="https://hub.jazz.net/project/lhayward/Laurens%20Lovely%20Landscapes%20%28IBM%20Graph%29/overview">here</a>.
  Or you can deploy the app to Bluemix (so you can see it running live and make changes to it) with the simple click of a button:
  
  <p>
    <a href="https://bluemix.net/deploy?repository=https://hub.jazz.net/git/lhayward/Laurens.Lovely.Landscapes.(IBM.Graph)" # [required]><img src="https://bluemix.net/deploy/button.png" alt="Deploy to Bluemix"></a>	
  </p>  
  
  <h3>Like videos?</h3>
  Me too!  Get the inside scoop on how I developed the app in my video series below.
  <iframe width="560" height="315" src="https://www.youtube.com/embed/ZQbYSEaUrTo?list=PLzpeuWUENMK0pcQ2z5jDlhB54ACZ0dkI5" frameborder="0" allowfullscreen></iframe>
  

  </div> <!-- end of the hero-unit-->
  </div> <!-- end of the container-->
  
<div class="container">
<div class="hero-unit">
  
  <div><h2><em>The Data</em><h2> </div>
  
  <h3>Schema diagram</h3>
  <img src="/static/images/schema.PNG">
  
  <h3>Graph of sample data</h3>
  <img src="/static/images/datagraph.PNG">
  
  <h3>Insert sample data</h3>
  Click <a href="insertSampleData">here</a> to insert the sample data.  Note that it may take a minute or two.
  
  <h3>Delete the data</h3>
  To start over with a fresh graph, click <a href="deleteData">here</a> to delete the data.
  
  <h3>Users</h3>
  <table class="table">
  	<thead>
  		<tr>
	  		<th>
	  			Username
	  		</th>
	  		<th>
	  			First Name
	  		</th>
	  		<th>
	  			Last Name
	  		</th>
	  		<th>
	  			Email
	  		</th>
  		</tr>
  	</thead>
  	<tbody>
  	% for user in users:
  		<tr>
  			<td>
  				{{user['properties']['username'][0]['value']}}
  			</td>
  			<td>
  				{{user['properties']['firstName'][0]['value']}}
  			</td>
  			<td>
  				{{user['properties']['lastName'][0]['value']}}
  			</td>
  			<td>
  				{{user['properties']['email'][0]['value']}}
  			</td>
  		</tr>
  	% end
  	</tbody>
  </table>
  
  <h3>Prints</h3>
  <table class="table">
  	<thead>
  		<tr>
	  		<th>
	  			Name
	  		</th>
	  		<th>
	  			Description
	  		</th>
	  		<th>
	  			Price
	  		</th>
	  		<th>
	  			Image Path
	  		</th>
  		</tr>
  	</thead>
  	<tbody>
  	% for p in prints:
  		<tr>
  			<td>
  				{{p['properties']['name'][0]['value']}}
  			</td>
  			<td>
  				{{p['properties']['description'][0]['value']}}
  			</td>
  			<td>
  				{{p['properties']['price'][0]['value']}}
  			</td>
  			<td>
  				{{p['properties']['imgPath'][0]['value']}}
  			</td>
  		</tr>
  	% end
  	</tbody>
  </table>
  
  <h3>Orders</h3>
  <div class="container">
  	% for order in orders:
  		<div class="row">
  			<div class="span4">
  				{{order['date']}} 
  			</div>
  			
  			<div class="span4">
  				{{order['username']}} <br>
  				{{order['printName']}} <br>
  				{{order['paymentMethod']}} <br>
  			</div>
  			
  			<div class="span4">
  				{{order['firstName']}} {{order['lastName']}} <br>
  				{{order['address1']}} <br>
  				% if len(order['address2']) > 0:
  				{{order['address2']}} <br>
  				% end
  				{{order['city']}}, {{order['state']}} {{order['zip']}}<br><br>
  			</div>
  		</div>
  	% end
  </div>
  
  <h3>Visualizing the Orders</h3>
  <p>
  	If you would like to visualize the orders in a graph, you can do so by 
  	<a href="https://bluemix.net/deploy?repository=https://hub.jazz.net/git/lhayward/Laurens.Lovely.Landscapes.(IBM.Graph)">deploying the app</a>
  	and then doing the following:
  	<ol>
  	    <li> If you have not already inserted the sample data in your deployed version of the app, complete the following steps:
  	         <ol>
	  	         <li> Open your deployed version of the app</li>
	  	         <li> Click <strong>&lt;for developers&gt;</strong> in the top menu</li>
	  	         <li> Click the link to <strong>insert the sample data</strong></li>
  	         </ol>
  	    </li>
  		<li> Log into <a href="http://bluemix.net" target="_blank">Bluemix</a> </li>
  		<li> In the Services section of the Dashboard, click on your app's Graph instance </li>
  		<li> Click <strong>Open</strong> </li>
  		<li> In the menu at the top of the page, select <strong>landscapes_graph</strong> to switch to the graph with your app's data (<strong>g</strong> is selected by default)
  		<li> Input a Gremlin query like the following and execute it: 
  			<code>
  				def gt = graph.traversal();gt.V().has("type", "user").outE("buys").inV().has("type","print").path();
  			</code>
  		</li>
  	</ol>
  </p>
  
  <p>
    The following video will walk you through the steps above, so you can visualize the orders.
  	<iframe width="560" height="315" src="https://www.youtube.com/embed/x0LHRZiGL8A?list=PLzpeuWUENMK0pcQ2z5jDlhB54ACZ0dkI5" frameborder="0" allowfullscreen></iframe>
  </p>
  
  </div> <!-- end of the hero-unit-->
  </div> <!-- end of the container-->
  
<div class="container">
<div class="hero-unit">  

  <div><h2><em>The Recommendation Engine</em><h2> </div>
  
  <p> 
    One of the biggest strengths of using a graph database is the ability to quickly generate 
    recommendations for your users.  This app generates three recommendations for its users on the 
    home page.  The recommendation engine used in this app is based on the 
    <a href="http://tinkerpop.apache.org/docs/current/recipes/#recommendation">
    Apache TinkerPop recipe for recommendations. </a>
  <p>
    The app generates personalized recommendations for a user who is authenticated by looking for 
    other users who have bought the same prints and seeing what they have purchased.  Below is 
    a detailed flow of the personalized recommendations:
    <ol>
    	<li> Find the node associated with the authenticated user. </li>
    	<li> Traverse the "buys" edges to find all of the print nodes the authenticated user has bought. </li>
    	<li> Traverse the "buys" edges to find all of the user nodes (excluding the authenticated user) who have purchased this set of prints. </li>
    	<li> Traverse the "buys" edges to find all of the prints (excluding the prints the authenticated user has bought) this set of users has bought. </li>
    	<li> Group and sort the print nodes to determine the top three prints this set of users has bought. </li>
    </ol>
  </p>
  <p>
    If less than three recommendations are generated (for example, if the user is not authenticated or if 
    the user loves the site and has purchased all of the prints), the app searches for the most purchased
    prints and presents them in the remaining recommendation spots.
  </p>
  <p>
    Take a look at getRecommendedPrints() in 
    <a href="https://hub.jazz.net/project/lhayward/Laurens%20Lovely%20Landscapes%20%28IBM%20Graph%29/overview#https://hub.jazz.net/git/lhayward%252FLaurens.Lovely.Landscapes.%2528IBM.Graph%2529/contents/master/graph.py">
    graph.py</a> to see the associated code.
  </p>
  <p>
    The following video will walk you through the theory and code behind the recommendation engine.
    <iframe width="560" height="315" src="https://www.youtube.com/embed/cAFRpWoN6ZQ?list=PLzpeuWUENMK0pcQ2z5jDlhB54ACZ0dkI5" frameborder="0" allowfullscreen></iframe>
  </p>

% include footer