import json

def lambda_handler(event, context):
    complaint_id = event['queryStringParameters']['complaint_id']
    #placeholder, normally gotten from db
    response = {
        "complaint_id" : complaint_id,
        "status" : "in-progress"
    }
    return{
        "statuscode: 200,"
        "body" :json.dumps(response)
    }