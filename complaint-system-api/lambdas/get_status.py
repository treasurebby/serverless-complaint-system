import json
import boto3

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table("Complaints")

def lambda_handler(event, context):
    complaint_id = event['queryStringParameters'].get('complaint_id')
    
    if not complaint_id:
        return{"statuscode" : 400,
               "body" : json.dumps({"error": "complaint_id is required"})}
    
    
    response =table.get_item(Key={"complaintId": complaint_id})
    
    if "Item" not in response:
        return{
            "statuscode": 404,
            "body" : json.dumps({"error": "complaint not found"})
        }
    
    
    return{
        "statuscode: 200,"
        "body" :json.dumps(response["Item"])
    }