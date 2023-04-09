import os
import boto3

sourceArn = os.environ["SOURCE_ARN"]
client = boto3.client('ses')

def email_handler(event, context):
    subject = event['subject']
    body = event['body']
    toEmail = event['to']
    fromEmail = event['from']
    replyToEmail = event['replyTo']

    message = {
        'Body': {
            'Html': {
                'Charset': 'utf-8',
                'Data': body,
            },
        },
        'Subject': {
            'Charset': 'utf-8',
            'Data': subject,
        },
    }

    response = client.send_email(
        SourceArn=sourceArn,
        Source=fromEmail,
        Destination={
          'ToAddresses': [
            toEmail,
          ]
        },
        ReplyToAddresses=[
          replyToEmail,
        ],
        Message=message,
    )

    print(f"ses response id received: {response['MessageId']}.")
