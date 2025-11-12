<?php

namespace App\Http\Controllers;

use App\Http\Requests\LoginRequest;
use App\Http\Requests\RegisterRequest;
//use GuzzleHttp\Psr7\Response;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Http\JsonResponse;
//use Illuminate\Http\Response;
use \Symfony\Component\HttpFoundation\Response;

class AuthController extends Controller
{
    /**
     * Register a user
     * @param \App\Http\Requests\RegisterRequest $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function register(RegisterRequest $request) {
        $data = $request->validated();
        $data["password"] = Hash::make( $data["password"] );
        $data["username"] = strstr($data["email"],"@", true);

        $user = User::create( $data );
        $token = $user->createToken(User::USER_TOKEN);

        return $this->success([
            "user"=>$user,
            "token"=> $token->plainTextToken,
        ], message: 'User has been register successfully.');
    }

    /**
     * Logins a user
     * @param \App\Http\Requests\LoginRequest $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function login(LoginRequest $request): JsonResponse {
        $isValid = $this->isValideCredential($request);
        if (!$isValid['success']) {
            return $this->error($isValid['message'], Response::HTTP_UNPROCESSABLE_ENTITY);
        }

        $user = $isValid['user'];
        $token = $user->createToken(User::USER_TOKEN);

        return $this->success([
            'user'=>$user,
            'token'=> $token->plainTextToken,
        ], 'Login successfully!');
    }

    /**
     * Validate user credantial
     * @param \App\Http\Requests\LoginRequest $request
     * @return array
     */
    private function isValideCredential(LoginRequest $request): array {
        $data = $request->validated();

        $user = User::where('email', $data['email'])->first();
        if( $user == null ) {
            return [
                'success'=> false,
                'message'=> 'Invalide credential'
            ];
        }

        if(Hash::check($data['password'], $user->password)) {
            return [
                'success'=> true,
                'user'=>$user
            ];
        }

        return [
            'success'=> false,
            'message'=> "Password isn't matched"
        ];
    }

    /**
     * Login  a user with token
     * 
     * @retrun JsonResponse
     */
    public function loginWithToken(): JsonResponse {
        return $this->success(auth()->user(), 'Login successfully!');
    }

    /**
     * Logout a user
     * @param \Illuminate\Http\Request $request
     * @return JsonResponse
     */
    public function logout(Request $request): JsonResponse {
        $request->user()->currentAccessToken()->delete();
        return $this->success(null,'Logout successfully!');
    }
}
