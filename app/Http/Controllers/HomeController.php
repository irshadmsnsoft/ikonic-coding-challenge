<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Connection;
use Illuminate\Http\Request;

class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth');
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    public function index()
    {
        return view('dashboard');
    }
    public function suggestionRequests() {
        $authId = auth()->user()->id;
        $connectIds = Connection::where(function ($query) use ($authId) {
            $query->where('request_from', $authId)
                ->orWhere('request_to', $authId);
        })
        ->pluck('request_from', 'request_to')
        ->toArray();
        // Merge the values and remove duplicates
        $connectIds = array_values(array_unique(array_merge(array_keys($connectIds), array_values($connectIds))));
        $users = User::whereNotIn('id', $connectIds)->get();
        return response()->json($users);
    }
    public function sentRequests() {
        $authId = auth()->user()->id;
        $userIds = Connection::where('request_from', $authId)
                ->where('status','pending')
                ->pluck('request_to');
        $users = User::whereIn('id', $userIds)->get();
        return response()->json($users);
    }
    public function receivedRequests() {
        $authId = auth()->user()->id;
        $userIds = Connection::where('request_to', $authId)->where('status','pending')->pluck('request_from');
        $users = User::whereIn('id', $userIds)->get();
        return response()->json($users);
    }
    public function connections() {
        $authId = auth()->user()->id;
        $requestTo = Connection::where('request_from', $authId)
            ->where('status','accepted')
            ->pluck('request_to')
            ->toArray();
        $requestFrom = Connection::where('request_to', $authId)
            ->where('status','accepted')
            ->pluck('request_from')
            ->toArray();
        $connectIds = array_unique(array_merge($requestTo, $requestFrom));
        // dd($connectIds);
        $users = User::whereIn('id', $connectIds)->get();
        foreach( $users as $user){
            $userTo = Connection::where('request_from', $user->id)
            ->where('status', 'accepted')
            ->pluck('request_to')->toArray();
            $userFrom = Connection::where('request_to', $user->id)
            ->where('status', 'accepted')
            ->pluck('request_from')->toArray();
        $relatedIds = array_unique(array_merge($userTo, $userFrom));
        $commonConnections = array_intersect($connectIds, $relatedIds);
        // dd($relatedIds);
        $commonUsers = User::whereIn('id', $commonConnections)->get();
        $user->commonConnectionsCount = count($commonConnections);
        $user->commonUsers =$commonUsers;
        }
        return response()->json($users);
    }
    public function connectionRequest($id) {
        $authId = auth()->user()->id;
        $connection = new Connection();
        $connection->request_from = $authId;
        $connection->request_to = $id;
        $connection->status = 'pending';
        $connection->save();
        return response()->json($connection);
    }
    public function withdrawRequest($id) {
        $authId = auth()->user()->id;
        $connection= Connection::where('request_from', $authId)->where('request_to', $id)->first();
        $connection->delete();
        return response()->json($connection);
    }
    public function acceptRequest($id) {
        $authId = auth()->user()->id;
        $connection= Connection::where('request_to', $authId)
            ->where('request_from', $id)
            ->where('status','pending')
            ->first();
        $connection->status= 'accepted';
        $connection->update();
        return response()->json($connection);
    }
    public function removeConnection($id) {
        $authId = auth()->user()->id;
        $connection = Connection::where('request_from', $authId)
            ->where('request_to', $id)
            ->where('status', 'accepted')
            ->first();
        if($connection){
            $connection->delete();
        }else{
            $connection = Connection::where('request_to', $authId)
                ->where('request_from', $id)
                ->where('status', 'accepted')
                ->first();
            $connection->delete();
        }
        return response()->json($connection);
    }
}
