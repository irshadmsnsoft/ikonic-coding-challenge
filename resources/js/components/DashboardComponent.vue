<template>
    <div class="row justify-content-center mt-5">
  <div class="col-12">
    <div class="card shadow  text-white bg-dark">
      <div class="card-header">Coding Challenge - Network connections</div>
      <div class="card-body">
        <div class="btn-group w-100 mb-3" role="group" aria-label="Basic radio toggle button group">
          <input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off" checked>
          <label class="btn btn-outline-primary" for="btnradio1" id="get_suggestions_btn" @click="getSuggestions">Suggestions ({{ suggestionCount }})</label>
          <input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off">
          <label class="btn btn-outline-primary" for="btnradio2" @click="getSentRequests">Sent Requests ( {{ sentRequestCount }} )</label>
          <input type="radio" class="btn-check" name="btnradio" id="btnradio3" autocomplete="off">
          <label class="btn btn-outline-primary" for="btnradio3" id="get_received_requests_btn" @click="getReceivedRequests">Received
            Requests({{ receivedRequestCount }})</label>
          <input type="radio" class="btn-check" name="btnradio" id="btnradio4" autocomplete="off">
          <label class="btn btn-outline-primary" for="btnradio4" id="get_connections_btn" @click="getConnections">Connections ({{ connectionCount }})</label>
        </div>
        <hr>
        <div id="content" class="d-none">
            <div v-if="activeTab === 'suggestions'">
                <div class="p-2 bg-gray mb-2" v-for="item in displayedSuggestions" :key="item.id">
                    <span>
                        {{ item.email }}
                    </span>
                    <button class="btn btn-primary float-end" @click="sendConnectionRequest(item.id)">
                        Connect
                    </button>
                </div>
                <button v-if="displayedSuggestions.length < suggestions.length" @click="loadAll" class="btn btn-primary">
                    Load All
                </button>
            </div>
            <div v-else-if="activeTab === 'sentRequests'">
              <!-- Render Sent Requests Table -->
              <div class="p-2 bg-gray mb-2" v-for="item in displayedSentRequests" :key="item.id">
                    <span>
                        {{ item.email }}
                    </span>
                    <button class="btn btn-danger float-end" @click="withdrawRequest(item.id)">
                        Withdraw Request
                    </button>
                </div>
                <button v-if="displayedSentRequests.length < sentRequests.length" @click="loadAllSentRequest" class="btn btn-primary">
                    Load All
                </button>
              <!-- Similar structure as above -->
            </div>
            <div v-else-if="activeTab === 'receivedRequests'">
              <!-- Render Received Requests Table -->
              <div class="p-2 bg-gray mb-2" v-for="item in displayedReceivedRequests" :key="item.id">
                    <span>
                        {{ item.email }}
                    </span>
                    <button class="btn btn-primary float-end" @click="acceptRequest(item.id)">
                        Accept
                    </button>
                </div>
                <button v-if="displayedReceivedRequests.length < receivedRequests.length" @click="loadAllReceivedRequest" class="btn btn-primary">
                    Load All
                </button>
              <!-- Similar structure as above -->
            </div>
            <div v-else-if="activeTab === 'connections'">
              <!-- Render Connections Table -->
              <div class="p-2 bg-gray mb-2" v-for="item in displayedConnections" :key="item.id">
                    <span>
                        {{ item.email }}
                    </span>
                    <div class="float-end">
                        <button class="btn btn-primary me-2" @click="showCommonUsers(item)">
                            Connection in common ({{ item.commonConnectionsCount }})
                        </button>
                        <button class="btn btn-danger" @click="removeConnection(item.id)">
                            Remove Connection
                        </button>
                    </div>
                    <div v-if="item.showCommonUsers" class="mt-3 ps-3">
                        <div v-for="user in item.commonUsers" :key="user.id" class="p-2 mb-1 bg-black">
                            {{ user.email }}
                        </div>
                    </div>
                </div>
                <button v-if="displayedConnections.length < connections.length" @click="loadAllConnections" class="btn btn-primary">
                    Load All
                </button>
              <!-- Similar structure as above -->
            </div>
        </div>
      </div>
    </div>
  </div>
</div>
  </template>
  
  <script>
  export default {
    name: 'DashboardComponent',
    data() {
        return {
            suggestionCount: 0,
            sentRequestCount: 0,
            receivedRequestCount: 0,
            connectionCount: 0,
            activeTab: 'suggestions',
            suggestions: [], // Array to store user data
            sentRequests: [], // Array to store user data
            receivedRequests: [], // Array to store user data
            connections: [], // Array to store user data

            displayedSuggestions: [],
            displayedSentRequests: [],
            displayedReceivedRequests: [],
            displayedConnections: [],
        };
    },
    mounted() {
        // Fetch user data when the component is mounted
        this.getSentRequests();
        this.getReceivedRequests();
        this.getConnections();
        this.getSuggestions();
    },
    methods: {
        async getSuggestions() {
            this.activeTab = 'suggestions';
            try {
                const response = await fetch('/suggestion-requests'); // Adjust the endpoint URL based on your Laravel routes
                if (response.ok) {
                const data = await response.json();
                this.suggestions = data;
                this.suggestionCount = this.suggestions.length;
                this.displayedSuggestions = this.suggestions.slice(0, 5);
                // Optionally, you can display the content after fetching data
                document.getElementById('content').classList.remove('d-none');
                } else {
                console.error('Failed to fetch users');
                }
            } catch (error) {
                console.error('Error fetching users:', error);
            }
        },
        async getSentRequests() {
            this.activeTab = 'sentRequests';
            try {
                const response = await fetch('/sent-requests');
                if (response.ok) {
                    const data = await response.json();
                    this.sentRequests = data;
                    this.sentRequestCount = this.sentRequests.length;
                    this.displayedSentRequests = this.sentRequests.slice(0, 5);
                    document.getElementById('content').classList.remove('d-none');
                } else {
                    console.error('Failed to fetch first two users');
                }
            } catch (error) {
            console.error('Error fetching first two users:', error);
            }
        },
        async getReceivedRequests() {
            this.activeTab = 'receivedRequests';
            try {
                const response = await fetch('/received-requests');
                if (response.ok) {
                    const data = await response.json();
                    this.receivedRequests = data;
                    this.receivedRequestCount = this.receivedRequests.length;
                    this.displayedReceivedRequests = this.receivedRequests.slice(0, 5);
                    document.getElementById('content').classList.remove('d-none');
                } else {
                    console.error('Failed to fetch first two users');
                }
            } catch (error) {
            console.error('Error fetching first two users:', error);
            }
        },
        async getConnections() {
            this.activeTab = 'connections';
            try {
                const response = await fetch('/connections');
                if (response.ok) {
                    const data = await response.json();
                    this.connections = data;
                    this.connectionCount = this.connections.length;
                    this.displayedConnections = this.connections.slice(0, 5);
                    document.getElementById('content').classList.remove('d-none');
                } else {
                    console.error('Failed to fetch first two users');
                }
            } catch (error) {
            console.error('Error fetching first two users:', error);
            }
        },
        async sendConnectionRequest($id) {
            try {
                const response = await fetch('/connection-request/'+$id);
                if (response.ok) {
                    this.getSuggestions();
                    const data = await response.json();
                    this.users = data;
                    console.log('sent requests', data);
                    document.getElementById('content').classList.remove('d-none');
                } else {
                    console.error('Failed to fetch first two users');
                }
            } catch (error) {
            console.error('Error fetching first two users:', error);
            }
        },
        loadAll() {
        // Set displayedSuggestions to the complete list of suggestions
        this.displayedSuggestions = [...this.suggestions];
        },
        loadAllSentRequest() {
        // Set displayedSuggestions to the complete list of suggestions
        this.displayedSentRequests = [...this.sentRequests];
        },
        loadAllReceivedRequest() {
        // Set displayedSuggestions to the complete list of suggestions
        this.displayedReceivedRequests = [...this.receivedRequests];
        },
        loadAllConnections() {
        // Set displayedSuggestions to the complete list of suggestions
        this.displayedConnections = [...this.connections];
        },
        async withdrawRequest($id) {
            try {
                const response = await fetch('/withdraw-request/'+$id);
                if (response.ok) {
                    this.getSentRequests();
                    const data = await response.json();
                    this.users = data;
                    console.log('sent requests', data);
                    document.getElementById('content').classList.remove('d-none');
                } else {
                    console.error('Failed to fetch first two users');
                }
            } catch (error) {
            console.error('Error fetching first two users:', error);
            }
        },
        async acceptRequest($id) {
            try {
                const response = await fetch('/accept-request/'+$id);
                if (response.ok) {
                    this.getReceivedRequests();
                    const data = await response.json();
                    this.users = data;
                    console.log('sent requests', data);
                    document.getElementById('content').classList.remove('d-none');
                } else {
                    console.error('Failed to fetch first two users');
                }
            } catch (error) {
            console.error('Error fetching first two users:', error);
            }
        },
        async removeConnection($id) {
            try {
                const response = await fetch('/remove-connection/'+$id);
                if (response.ok) {
                    this.getConnections();
                    const data = await response.json();
                    this.users = data;
                    console.log('sent requests', data);
                    document.getElementById('content').classList.remove('d-none');
                } else {
                    console.error('Failed to fetch first two users');
                }
            } catch (error) {
            console.error('Error fetching first two users:', error);
            }
        },
        showCommonUsers(item) {
            item.showCommonUsers = !item.showCommonUsers;
        },
    },
  }
  </script>