<?php

namespace App\Http\Controllers;

use App\Models\User;

class UserController extends Controller
{
    /**
     * Get users except yourself
     * @return \Illuminate\Http\JsonResponse
     */
    public function index() {
        $users = User::where('id','!=',auth()->user()->id)->get();
        return $this->success($users);
    }
}
