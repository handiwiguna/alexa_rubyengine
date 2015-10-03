# AlexaRubyengine

# Installation

## Sample Application

For a sample application video tutorial, check the follow video bellow:

<a href="http://www.youtube.com/watch?feature=player_embedded&v=PwZf506UKHo" target="_blank"><img src="http://img.youtube.com/vi/PwZf506UKHo/0.jpg"
alt="Running a sample Rubykit Demo" width="240" height="180" border="5" /></a>

## Usage

For running the sample "say" application:
* Configure your endpoint for SSL for ElasticBeanStalk.

1. Follow the instructions at http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/create_deploy_Ruby_sinatra.html, this'll deploy the app to EBS.
2. Then follow the instructions at http://docs.aws.amazon.com/IAM/latest/UserGuide/InstallCert.html for installing and
uploading a SSL certificate to EBS, use the domain of the endpoint selected in the previous step (Important!).
3. In the ElasticBeanstalk management console, activate SSL port 443 and select the SSL certificate from the dropdown.
4. Ensure that the endpoint is alive by going to https://endpointurl.elastickbeanstalk.com.
Note: A 500 error is sent by default if a request is not made from an Alexa.
5.  In your Developer Portal, create a new Alexa application and follow the instructions in the official SDK.
Note: Use the certificate (server.crt) you created in the first step.
6. As intent and sample utterances, use the contents of IntentSchema.json and SampleUtterances.baf

That's it!

Say to your alexa "alexa open ruby" and Alexa will query your endpoint, and the sample app will say back "Hello, Rubby is running ready"!

## Troubleshooting

There are two sources of troubleshooting information: the Amazon Echo app/website and the EBS logs that you can get from
the management console.
- "Error in SSL handshake" : Make sure your used the FQDN when you generated the SSL and it's also the active SSL in EBS.
- "Error communicating with the application" : Query the EBS logs from the management console and create an issue on GitHub.


