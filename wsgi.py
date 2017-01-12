"""
/*-------------------------------------------------------------------*/
/*                                                                   */
/* Copyright IBM Corp. 2016 All Rights Reserved                      */
/*                                                                   */
/*-------------------------------------------------------------------*/
/*                                                                   */
/*        NOTICE TO USERS OF THE SOURCE CODE EXAMPLES                */
/*                                                                   */
/* The source code examples provided by IBM are only intended to     */
/* assist in the development of a working software program.          */
/*                                                                   */
/* International Business Machines Corporation provides the source   */
/* code examples, both individually and as one or more groups,       */
/* "as is" without warranty of any kind, either expressed or         */
/* implied, including, but not limited to the warranty of            */
/* non-infringement and the implied warranties of merchantability    */
/* and fitness for a particular purpose. The entire risk             */
/* as to the quality and performance of the source code              */
/* examples, both individually and as one or more groups, is with    */
/* you. Should any part of the source code examples prove defective, */
/* you (and not IBM or an authorized dealer) assume the entire cost  */
/* of all necessary servicing, repair or correction.                 */
/*                                                                   */
/* IBM does not warrant that the contents of the source code         */
/* examples, whether individually or as one or more groups, will     */
/* meet your requirements or that the source code examples are       */
/* error-free.                                                       */
/*                                                                   */
/* IBM may make improvements and/or changes in the source code       */
/* examples at any time.                                             */
/*                                                                   */
/* Changes may be made periodically to the information in the        */
/* source code examples; these changes may be reported, for the      */
/* sample code included herein, in new editions of the examples.     */
/*                                                                   */
/* References in the source code examples to IBM products, programs, */
/* or services do not imply that IBM intends to make these           */
/* available in all countries in which IBM operates. Any reference   */
/* to the IBM licensed program in the source code examples is not    */
/* intended to state or imply that IBM's licensed program must be    */
/* used. Any functionally equivalent program may be used.            */
/*-------------------------------------------------------------------*/
"""

import bottle
from bottle import *
import os,sys,logging, traceback, json, string, urllib, urllib2
import graph
import constants
import urlparse

graph.initializeGraph()

#Provide all the static css and js files under the static dir to browser
@route('/static/:filename#.*#')
def server_static(filename):
	""" This is for JS files """
	return static_file(filename, root='static')

# Displays the home page
@bottle.get("/")
@bottle.get("/home")
def getHome():
	username = request.get_cookie("account", secret=constants.COOKIE_KEY)
	return bottle.template('home', 
						username = username, 
						prints = graph.getAllPrints(),
						recommendedPrints = graph.getRecommendedPrints(username))

# Displays the page for the designated print
@bottle.get("/print/<printName>")
def getPrint(printName):
	try:
		printInfo = graph.getPrintInfo(printName)
		return bottle.template('print',
						username = request.get_cookie("account", secret=constants.COOKIE_KEY),
						printInfo = printInfo)
	except ValueError:
		return bottle.template('simpleMessage',
							username = request.get_cookie("account", secret=constants.COOKIE_KEY),
							title='Oops!',
							message='We can\'t find that print. Sorry!')	

# Lets the user order/buy a print
@bottle.get('/orderPrint/<printName>')
def getOrderForm(printName):
	
	username = request.get_cookie("account", secret=constants.COOKIE_KEY)
	if username is None or len(username) <= 0:
		return bottle.template('authenticateBeforeOrder', redirectUrl = 'orderPrint/' + printName)
	
	try:
		printInfo = graph.getPrintInfo(printName)    
	except ValueError as e:
		return bottle.template('simpleMessage',
							username = username,
							title='Oops!',
							message='An error occurred. Please try to order a print again.')
	
	return bottle.template('orderForm', printInfo = printInfo, username = username)
		
# Place the order
@bottle.post('/orderPrint')
def placeOrder():
	username = request.get_cookie("account", secret=constants.COOKIE_KEY)
	printToOrder = request.forms.get("print")
	firstName = request.forms.get("firstName")
	lastName = request.forms.get("lastName")
	address1 = request.forms.get("address1")
	address2 = request.forms.get("address2")
	city = request.forms.get("city")
	state = request.forms.get("state")
	zip = request.forms.get("zip")
	payment = request.forms.get("payment")
	datetime = str(time.strftime("%Y-%m-%d %H:%M:%S"))
	printInfo = graph.getPrintInfo(printToOrder)
	
	try:	
		graph.buyPrint(username, printToOrder, datetime, firstName, lastName, address1, address2, city, state, zip, payment)
		return bottle.template('orderSuccess',
							username = username,
							printToOrder=printToOrder,
							datetime=datetime,
							printInfo = printInfo,
							firstName=firstName,
							lastName=lastName,
							address1=address1,
							address2=address2,
							city=city,
							state=state,
							zip=zip,
							payment=payment)
	
	except ValueError as e:
		return bottle.template('orderForm', 
							error=e,
							username = username,
							printInfo = printInfo,
							firstName=firstName,
							lastName=lastName,
							address1=address1,
							address2=address2,
							city=city,
							state=state,
							zip=zip,
							payment=payment)
		
# Displays the registration page
@bottle.get("/register")
def getRegistration():
	try:
		redirectUrl = urlparse.parse_qs(urlparse.urlparse(request.url).query)['redirectUrl'][0]
	except:
		redirectUrl = 'home'
	return bottle.template('register', redirectUrl = redirectUrl)

@bottle.post('/register')
def registerUser():
	firstName = request.forms.get('firstName')
	lastName = request.forms.get("lastName")
	email = request.forms.get("email")
	username = request.forms.get("username")
	redirectUrl = request.forms.get("redirectUrl")
	
	try:
		# create the user in the graph
		graph.createUser(firstName, lastName, username, email)
		# authenticate the user
		response.set_cookie("account", username, secret=constants.COOKIE_KEY)
		
		if 'orderPrint' in redirectUrl:
			return redirect(request.forms.get("redirectUrl"))
		
		return bottle.template('simpleMessage',
							username = username,
							title='Success!',
							message='You\'re successfully registered. Now go buy something!')
	except ValueError as e:
		return bottle.template('register', 
							error=e,
							firstName=firstName,
							lastName=lastName,
							email=email,
							redirectUrl=redirectUrl)
		
# Displays the profile page
@bottle.get("/profile")
def getProfile():
	username = request.get_cookie("account", secret=constants.COOKIE_KEY)
	if username is None or len(username) <= 0:
		return bottle.template('simpleMessage',
							username = username,
 							title='Oops!',
 							message='You need to sign in before you can edit your profile.')
	return bottle.template('profile', username = username, userInfo = graph.getUser(username))

# Handles the Edit Profile form
@bottle.post('/profile')
def updateProfile():
	firstName = request.forms.get("firstName")
	lastName = request.forms.get("lastName")
	email = request.forms.get("email")
	username = request.get_cookie("account", secret=constants.COOKIE_KEY)
	
	try:
		# update the user in the graph
		graph.updateUser(username, firstName, lastName, email)
 		
		return bottle.template('simpleMessage',
							username = username,
							title='Success!',
							message='You\'ve successfully updated your profile!')
	except ValueError as e:
		return bottle.template('profile', 
							error=e,
							firstName=firstName,
							lastName=lastName,
							email=email,
							username=username)

# Displays the Sign In page
@bottle.get("/signin")
def getSignin():
    try:
        redirectUrl = urlparse.parse_qs(urlparse.urlparse(request.url).query)['redirectUrl'][0]
    except:
        redirectUrl = 'home'
    return bottle.template('signin', redirectUrl=redirectUrl)    

# Displays the Sign In page
@bottle.post('/signin')
def signIn():
	username = request.forms.get("username")
	# for simplicity, not dealing with passwords
	# if the username exists in the graph, we will authenticate the user
	if graph.doesUserExist(username):
		print 'Authenticating user %s' % username
		response.set_cookie("account", username, secret=constants.COOKIE_KEY)
		redirect(request.forms.get("redirectUrl"))
	else:
		print 'Unable to authenticate user %s' % username
		return bottle.template('signin', 
							error='Unable to find an account with the given username. Please try again.',
							redirectUrl = request.forms.get("redirectUrl"))

@bottle.get('/signout')
def signOut():
	print 'Signing out user'
	response.delete_cookie("account")
	redirect(urlparse.parse_qs(urlparse.urlparse(request.url).query)['redirectUrl'][0])
		
# Inserts the sample data
@bottle.get("/insertSampleData")
def insertSampleData():
	try:	
		graph.insertSampleData()
		return bottle.template('simpleMessage', 
							username = request.get_cookie("account", secret=constants.COOKIE_KEY),
							title='Sample Data Created', 
							message='Woo hoo!  The sample data was created!')
	except ValueError as e:
		print e
		return bottle.template('simpleMessage', 
							username = request.get_cookie("account", secret=constants.COOKIE_KEY),
							title='Oops!  Something went wrong!', 
							message=e)

# Deletes the data in the graph
@bottle.get("/deleteData")
def deleteData():
	try:	
		graph.dropGraph()
		return bottle.template('simpleMessage', 
							username = request.get_cookie("account", secret=constants.COOKIE_KEY),
							title='Data deleted', 
							message='Woo hoo!  The sample data was deleted!')
	except ValueError as e:
		print e
		return bottle.template('simpleMessage', 
							username = request.get_cookie("account", secret=constants.COOKIE_KEY),
							title='Oops!  Something went wrong!', 
							message=e)

@bottle.get("/dev")
def getPageForDevelopers():
	return bottle.template('dev', 
						username = request.get_cookie("account", secret=constants.COOKIE_KEY),
						users = graph.getAllUsers(),
						prints = graph.getAllPrints(),
						orders = graph.getAllOrders())
	
# Error Methods
@bottle.error(404)
def error404(error):
    print '404'
    return bottle.template('simpleMessage', 
						username = request.get_cookie("account", secret=constants.COOKIE_KEY),
						title='404', 
						message='We can\'t find that page.  Sorry!')


application = bottle.default_app()

if __name__ == '__main__':
    port = int(os.getenv('PORT', '8000'))
    bottle.run(host='0.0.0.0', port=port)
