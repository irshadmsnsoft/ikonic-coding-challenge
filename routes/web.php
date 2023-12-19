<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\HomeController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});



Route::get('/home', [HomeController::class, 'index'])->name('home');

Route::get('/suggestion-requests', [HomeController::class, 'suggestionRequests']);
Route::get('/sent-requests', [HomeController::class, 'sentRequests']);
Route::get('/received-requests', [HomeController::class, 'receivedRequests']);
Route::get('/connections', [HomeController::class, 'connections']);

Route::get('/connection-request/{id}', [HomeController::class, 'connectionRequest']);
Route::get('/withdraw-request/{id}', [HomeController::class, 'withdrawRequest']);
Route::get('/accept-request/{id}', [HomeController::class, 'acceptRequest']);
Route::get('/remove-connection/{id}', [HomeController::class, 'removeConnection']);
