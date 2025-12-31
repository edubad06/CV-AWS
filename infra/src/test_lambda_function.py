import json
import unittest
from unittest.mock import MagicMock, patch
from lambda_function import lambda_handler

class TestVisitorCounter(unittest.TestCase):

    @patch('lambda_function.table')
    def test_visitor_counter_increments(self, mock_table):
        # Mock DynamoDB response
        mock_table.update_item.return_value = {
            'Attributes': {
                'visits': 5
            }
        }

        # Mock Event with cv_id
        event = {
            'queryStringParameters': {
                'cv_id': 'default'
            }
        }
        
        # Call function
        result = lambda_handler(event, None)
        
        # Assertions
        self.assertEqual(result['statusCode'], 200)
        self.assertIn('5', result['body'])
        
        # Verify DynamoDB was called correctly
        mock_table.update_item.assert_called_once()
        call_args = mock_table.update_item.call_args[1]
        self.assertEqual(call_args['Key']['cv_id'], 'default')

    @patch('lambda_function.table')
    def test_visitor_counter_handles_missing_params(self, mock_table):
        # Mock response
        mock_table.update_item.return_value = {'Attributes': {'visits': 1}}
        
        # Event without query params (simulating direct invoke or weird proxy)
        event = {} 
        
        result = lambda_handler(event, None)
        
        self.assertEqual(result['statusCode'], 200)
        self.assertEqual(json.loads(result['body'])['visits'], 1)
        
        # Verify it used default key
        call_args = mock_table.update_item.call_args[1]
        self.assertEqual(call_args['Key']['cv_id'], 'default')

if __name__ == '__main__':
    unittest.main()
