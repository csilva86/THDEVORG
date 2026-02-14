public with sharing class CardanoIntegrationService {
    public CardanoIntegrationService() {

    }

    public static String getCardanoBlockInfo(String blockHash) {
        String keyValue = '5a2cc4aa-2376-4a4c-9170-b2f800be067d';
        // Placeholder for actual API call to Cardano blockchain
        //    Request
        Http http = new Http();
        HttpRequest request = new HttpRequest();

        request.setMethod('GET');
        request.setEndpoint('https://api.cardanoscan.io/api/v1/block?blockHash=' + EncodingUtil.urlEncode(blockHash, 'UTF-8'));
        request.setHeader('apiKey', keyValue);

        //    Response
        HttpResponse response = http.send(request);

        if(response.getStatusCode() == 200) {
            // Process the response and extract block information
            String responseBody = response.getBody();
            // Parse untyped JSON to avoid illegal assignment and handle schema variations
            Map<String, Object> payload = (Map<String, Object>) JSON.deserializeUntyped(responseBody);

            // Safely extract fields
            String hash = (String) payload.get('hash');
            String previousBlockHash = (String) payload.get('previousBlockHash');
            Object heightRaw = payload.get('blockHeight');
            Integer blockHeight = heightRaw instanceof Integer ? (Integer) heightRaw :
                                  heightRaw instanceof Long ? Integer.valueOf((Long) heightRaw) :
                                  heightRaw instanceof Decimal ? ((Decimal) heightRaw).intValue() : null;
            String timestamp = (String) payload.get('timestamp');

            String blockInfoString = 'Block Hash: ' + (hash != null ? hash : '') + '\n' +
                                     'Previous Block Hash: ' + (previousBlockHash != null ? previousBlockHash : '') + '\n' +
                                     'Block Height: ' + (blockHeight != null ? String.valueOf(blockHeight) : '') + '\n' +
                                     'Block Time: ' + (timestamp != null ? timestamp : '');
            
            return blockInfoString;
        } else {
            // Handle errors appropriately
            System.debug('Error fetching block info: ' + response.getStatusCode());
            System.debug('Response body: ' + response.getBody());
            return 'Error fetching block info: ' + response.getStatusCode();

        }

        // In a real implementation, you would use HTTP callouts to fetch data from the Cardano API
        //return 'Block info for hash: ' + blockHash;
    }

    public static String buscarBlocos() {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        request.setMethod('GET');
        request.setEndpoint('https://api.cardanoscan.io/api/v1/block/latest');
        
        // Substitua pelo seu token real
        request.setHeader('apiKey', '5a2cc4aa-2376-4a4c-9170-b2f800be067d');
        
        HttpResponse response = http.send(request);
        
        if (response.getStatusCode() == 200) {

            // Parse the JSON response
            blockInfo blockInfo = (blockInfo) JSON.deserialize(response.getBody(), blockInfo.class);
            System.debug('Block Information: Objeto blockInfo criado a partir do JSON');
            System.debug('Block Hash: ' + blockInfo.hash);
            System.debug('Previous Block Hash: ' + blockInfo.previousBlockHash);
            System.debug('Block Height: ' + blockInfo.blockHeight);
            System.debug('Block Time: ' + blockInfo.timestamp);
            System.debug('Block Info: ' + blockInfo);

            return response.getBody();
        } else {
            throw new CalloutException(
                'Erro na chamada: ' + response.getStatus() + 
                ' - ' + response.getBody()
            );
        }
    }





    // DTO class to represent block information
    public class blockInfo{
        public String hash;	//f227ea7425930986d1dee8c52759855a8a89b613add789176632e80e3052b3b1
        public String previousBlockHash;	//2eccf5fe04284f45b2ba95b1c200ac6d66c3a07be972235bb7f8383097a27726
        public Integer blockHeight;	//13028046
        public String totalFees;	//2206616
        public Integer slot;	//263984
        public Integer epoch;	//612
        public Integer absSlot;	//179284784
        public String timestamp;	//2026-02-11T23:04:35.000Z
        public Integer txCount;	//6
        public Integer assetTxCount;	//0
        public String totalOutput;	//3634612834660
        public String slotLeader;	//9dfeca095f80562460252072fd8438f08936ef5a2077583a9722bd97
        public Integer bodySize;	//9503
        public String protocolVersion;	//10.2
    }

    public static blockInfo parse(String json){
        //String json = buscarBlocos();
        blockInfo block = (blockInfo) System.JSON.deserialize(json, blockInfo.class);
        return block;
    }
}