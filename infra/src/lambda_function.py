import json
import boto3
import os
from decimal import Decimal

dynamodb = boto3.resource('dynamodb')
table_name = os.environ.get('TABLE_NAME', 'visitor_count')
table = dynamodb.Table(table_name)

# Helper class to convert a DynamoDB item to JSON.
class DecimalEncoder(json.JSONEncoder):
    def default(self, o):
        if isinstance(o, Decimal):
            return int(o)
        return super(DecimalEncoder, self).default(o)

def lambda_handler(event, context):
    # Leer cv_id desde query string, default 'default'
    query_params = event.get('queryStringParameters') or {}
    cv_id = query_params.get('cv_id', 'default')
   
    try:
        response = table.update_item(
            Key={'cv_id': cv_id},
            UpdateExpression="SET visits = if_not_exists(visits, :start) + :inc",
            ExpressionAttributeValues={':inc': 1, ':start': 0},
            ReturnValues="UPDATED_NEW"
        )
       
        visits = response['Attributes']['visits']
       
        return {
            'statusCode': 200,
            'headers': {
                'Access-Control-Allow-Headers': 'Content-Type',
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Methods': 'OPTIONS,POST,GET'
            },
            'body': json.dumps({'visits': int(visits)}, cls=DecimalEncoder)
        }
    except Exception as e:
        print(e)
        return {'statusCode': 500, 'body': json.dumps({'error': str(e)})}
