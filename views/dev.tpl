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
  <table class="table">
  	<thead>
  		<tr>
	  		<th>
	  			Date & Time
	  		</th>
	  		<th>
	  			First Name
	  		</th>
	  		<th>
	  			Last Name
	  		</th>
	  		<th>
	  			Address 1
	  		</th>
	  		<th>
	  			Address 2
	  		</th>
	  		<th>
	  			City
	  		</th>
	  		<th>
	  			State
	  		</th>
	  		<th>
	  			Zip
	  		</th>
	  		<th>
	  			Payment Method
	  		</th>
  		</tr>
  	</thead>
  	<tbody>
  	% for order in orders:
  		<tr>
  			<td>
  				{{order['properties']['date']}}
  			</td>
  			<td>
  				{{order['properties']['firstName']}}
  			</td>
  			<td>
  				{{order['properties']['lastName']}}
  			</td>
  			<td>
  				{{order['properties']['address1']}}
  			</td>
  			<td>
  				{{order['properties']['address2']}}
  			</td>
  			<td>
  				{{order['properties']['city']}}
  			</td>
  			<td>
  				{{order['properties']['state']}}
  			</td>
  			<td>
  				{{order['properties']['zip']}}
  			</td>
  			<td>
  				{{order['properties']['paymentMethod']}}
  			</td>
  		</tr>
  	% end
  	</tbody>
  </table>
  
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

% include footer